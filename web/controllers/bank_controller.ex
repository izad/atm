defmodule Atm.BankController do
  use Atm.Web, :controller

  alias Atm.Bank

  def index(conn, _params) do
    banks = Repo.all(Bank)
    render(conn, "index.json", banks: banks)
  end

  def show(conn, %{"id" => id}) do
    bank = Repo.get!(Bank, id)
    render(conn, "show.json", bank: bank)
  end  
end
