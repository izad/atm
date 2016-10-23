defmodule Atm.BankView do
  use Atm.Web, :view

  def render("index.json", %{banks: banks}) do
    render_many(banks, Atm.BankView, "bank.json")
  end

  def render("show.json", %{bank: bank}) do
    render_one(bank, Atm.BankView, "bank.json")
  end

  def render("bank.json", %{bank: bank}) do
    %{
      id: bank.id,
      name: bank.name,
      logo_url: bank.logo_url,
      inserted_at: bank.inserted_at,
      updated_at: bank.updated_at
    }
  end
end
