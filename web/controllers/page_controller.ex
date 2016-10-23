defmodule Atm.PageController do
  use Atm.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
