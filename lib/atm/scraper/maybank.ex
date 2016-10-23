defmodule Atm.Scraper.Maybank do
  alias Atm.Scraper.Helper
  alias Atm.{Repo, Bank, Location}
  #alias Ecto.Multi

  import Ecto.Query, only: [from: 2, first: 1]

  def perform(type) do
    bank =
      from(b in Bank, where: b.name == "Maybank")
      |> first
      |> Repo.one

    HTTPoison.get!("http://www.maybank2u.com.my/mbb_info/m2u/public/customerService.do?programId=CS-CustService&chCatId=/mbb/Personal")
    |> Helper.parse_response
    |> parse(bank, type)
  end

  def parse(html, bank, type) do
    html
    |> Floki.find("select")
    |> Enum.at(1)
    |> Floki.find("option")
    |> Enum.filter(&filter_state/1)
    |> iterate_states(bank, type)
  end

  def parse(html, bank) do
    headings = Floki.find(html, "#leftCol h3")
    tables = Floki.find(html, "#mainColomn > #leftCol > table")

    Enum.each(headings, fn heading ->
      name =
        heading
        |> Floki.text
        |> String.strip

      index = Enum.find_index(headings, &(&1 == heading))

      address =
        tables
        |> Enum.at(index)
        |> Floki.find("td")
        |> Enum.at(2)
        |> Floki.raw_html
        |> String.split("<strong>Facilities</strong>")
        |> hd
        |> Floki.text
        |> String.replace("\r", "")
        |> String.replace("\t", "")
        |> String.replace("\n\n\n\n\n", "\n")
        |> String.replace("\n\n\n\n", "\n")
        |> String.replace("\n\n\n", "\n")
        |> String.replace("\n\n", "\n")
        |> String.replace("\n", " ")
        |> String.strip

      location =
        from(l in Location, where: l.name == ^name)
        |> first
        |> Repo.one

      if String.valid?(address) and is_nil(location) do
        location = Ecto.build_assoc(bank, :locations)
        changeset = Location.insertion_changeset(location, %{name: name, address: address})

        case Repo.insert(changeset) do
          {:ok, location} ->
            IO.inspect location

          {:error, _changeset} ->
            IO.inspect "Failed to fetch coordinate"
        end
      end
    end)
  end

  def filter_state(option) do
    [value] = Floki.attribute(option, "value")
    value != ""
  end

  def iterate_states(options, bank, type) do
    Enum.each(options, fn option ->
      [value] = Floki.attribute(option, "value")
      url = "http://www.maybank2u.com.my/mbb_info/m2u/public/customerServiceBranchDetailsList.do?state=#{value}&branch=#{type_to_binary(type)}&channelId=&cs=1&programId=CS-CustService&chCatId=%2Fmbb%2FPersonal"

      HTTPoison.get!(url)
      |> Helper.parse_response
      |> parse(bank)
    end)
  end

  def type_to_binary(:branch), do: "Branches"
  def type_to_binary(:offsite), do: "ATM off branch"

end
