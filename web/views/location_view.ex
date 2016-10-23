defmodule Atm.LocationView do
  use Atm.Web, :view

  def render("index.json", %{locations: locations}) do
    render_many(locations, Atm.LocationView, "location.json")
  end

  def render("location.json", %{location: location}) do
    %{
      id: location.id,
      name: location.name,
      address: location.address,
      lat: location.lat,
      lng: location.lng,
      bank: render_one(location.bank, Atm.BankView, "bank.json"),
      inserted_at: location.inserted_at,
      updated_at: location.updated_at
    }
  end
end
