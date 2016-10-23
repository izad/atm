defmodule Atm.PageView do
  use Atm.Web, :view

  def render("index.json", _params) do
    %{version: "1.0"}
  end
end
