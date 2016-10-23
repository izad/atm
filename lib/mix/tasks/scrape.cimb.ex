defmodule Mix.Tasks.Scrape.Cimb do
  use Mix.Task

  @shortdoc "Scrape CIMB ATM locations"

  def run(argv) do
    Mix.Task.run "app.start"
    Atm.Scraper.Cimb.perform
  end

end
