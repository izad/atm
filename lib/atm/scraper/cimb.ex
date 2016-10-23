defmodule Atm.Scraper.Cimb do

  def perform do
    case System.cmd "phantomjs", ["cimb.js"] do
      {string, 0} ->
        string
        |> String.split("###")
        |> List.last
        |> IO.inspect        

      _ ->
        IO.puts "PhantomJS Error"
    end
  end

end
