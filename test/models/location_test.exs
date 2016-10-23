defmodule Atm.LocationTest do
  use Atm.ModelCase

  alias Atm.Location

  @valid_attrs %{address: "some content", lat: "120.5", lng: "120.5", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Location.changeset(%Location{}, @valid_attrs)
    IO.inspect changeset
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Location.changeset(%Location{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "coordinate inserted on create" do
    changeset = Location.insertion_changeset(%Location{}, %{name: "Ipoh", address: "Ground & Mezzanine Floor, Lot 215, Jalan Song Thian Cheok, 93100 Kuching, Sarawak"})

    refute is_nil(changeset.changes.lat)
    refute is_nil(changeset.changes.lng)
  end
end
