defmodule Atm.Scraper.Helper do

  def parse_response(%HTTPoison.Response{body: body}) do
    body
  end

end
