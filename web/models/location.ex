defmodule Atm.Location do
  use Atm.Web, :model

  @required_fields [:name, :address, :lat, :lng]

  schema "locations" do
    belongs_to :bank, Atm.Bank

    field :name, :string
    field :address, :string
    field :lat, :float
    field :lng, :float

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end

  def insertion_changeset(struct, params) do
    struct
    |> cast(params, @required_fields)
    |> put_coordinate(params)
    |> validate_required(@required_fields)
  end

  def put_coordinate(changeset, %{address: address}) do
    %HTTPoison.Response{body: body} = HTTPoison.get!("https://maps.googleapis.com/maps/api/geocode/json", [], params: [
      key: "AIzaSyCNbo7o_4LmZRkmXEVr9NC2Ng2EWbU2_es",
      address: address
    ])

    response = Poison.decode!(body)
    put_coordinate(changeset, response["results"])
  end

  def put_coordinate(changeset, %{}), do: changeset

  def put_coordinate(changeset, [head | _]) do
    %{"geometry" => %{"location" => %{"lat" => lat, "lng" => lng}}} = head

    changeset
    |> put_change(:lat, lat)
    |> put_change(:lng, lng)
  end

  def put_coordinate(changeset, []), do: changeset

end
