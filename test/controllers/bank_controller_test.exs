defmodule Atm.BankControllerTest do
  use Atm.ConnCase

  alias Atm.Bank
  @valid_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, bank_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    bank = Repo.insert! %Bank{}
    conn = get conn, bank_path(conn, :show, bank)
    assert json_response(conn, 200)["data"] == %{"id" => bank.id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, bank_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, bank_path(conn, :create), bank: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Bank, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, bank_path(conn, :create), bank: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    bank = Repo.insert! %Bank{}
    conn = put conn, bank_path(conn, :update, bank), bank: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Bank, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    bank = Repo.insert! %Bank{}
    conn = put conn, bank_path(conn, :update, bank), bank: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    bank = Repo.insert! %Bank{}
    conn = delete conn, bank_path(conn, :delete, bank)
    assert response(conn, 204)
    refute Repo.get(Bank, bank.id)
  end
end
