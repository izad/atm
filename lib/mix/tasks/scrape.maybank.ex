defmodule Mix.Tasks.Scrape.Maybank do
  use Mix.Task

  @shortdoc "Scrape Maybank ATM locations"

  def run(argv) do
    Mix.Task.run "app.start"

    argv
    |> parse_argv
    |> process
  end

  def parse_argv(argv) do
    case OptionParser.parse(argv) do
      {_, [type], _} ->
        type
        |> String.downcase
        |> String.to_atom

      _ ->
        :help
    end
  end

  def process(:branch = type) do
    Atm.Scraper.Maybank.perform(type)
  end

  def process(:offsite = type) do
    Atm.Scraper.Maybank.perform(type)
  end

  def process(_) do
    IO.puts "usage: mix scrape.maybank <type>"
    System.halt(0)
  end
end
