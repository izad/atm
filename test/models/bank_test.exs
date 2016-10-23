defmodule Atm.BankTest do
  use Atm.ModelCase

  alias Atm.Bank

  @valid_attrs %{logo_url: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Bank.changeset(%Bank{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Bank.changeset(%Bank{}, @invalid_attrs)
    refute changeset.valid?
  end
    
end
