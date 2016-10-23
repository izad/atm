defmodule Atm.Scraper.Cimb do
  alias Atm.{Repo, Bank, Location}
  import Ecto.Query, only: [from: 2, first: 1]

  def perform do
    bank =
      from(b in Bank, where: b.name == "CIMB Bank")
      |> first
      |> Repo.one

    case System.cmd "phantomjs", ["cimb.js"] do
      {string, 0} ->
        string
        |> String.split("###")
        |> List.last
        |> String.split("|")
        |> Enum.each(fn line -> parse(line, bank) end)

      _ ->
        nil
    end
  end

  def parse(line, bank) do
    components =
      line
      |> String.split(";")
      |> Enum.map(fn elem -> String.strip(elem) end)
      |> Enum.slice(0, 4)

    case components do
      [_, "", "", _] ->
        nil

      [name, lat, lng, address] ->
        location =
          from(l in Location, where: l.name == ^name)
          |> first
          |> Repo.one

        if is_nil(location) do
          address =
            address
            |> String.replace("<br /><br /><br /><br />", "<br />")
            |> String.replace("<br /><br /><br />", "<br />")
            |> String.replace("<br /><br />", "<br />")
            |> String.replace("<br />", ", ")
            |> String.replace(",,", ",")
            |> String.split(" ")
            |> Enum.filter(fn elem -> String.length(elem) > 0 end)
            |> Enum.join(" ")
            |> String.replace(", ,", ",")

          params = %{
            name: name,
            lat: String.to_float(lat),
            lng: String.to_float(lng),
            address: address
          }

          location = Ecto.build_assoc(bank, :locations)
          changeset = Location.changeset(location, params)

          case Repo.insert(changeset) do
            {:ok, location} ->
              IO.inspect location

            {:error, _changeset} ->
              nil
          end
        end

      _ ->
        nil
    end
  end

end
