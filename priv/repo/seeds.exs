# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Atm.Repo.insert!(%Atm.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Atm.{Repo, Bank}

Repo.insert!(%Bank{name: "Maybank", logo_url: "https://d3nqkn4zfk4y3n.cloudfront.net/bank-logos/maybank.png"})
Repo.insert!(%Bank{name: "CIMB Bank", logo_url: "https://d3nqkn4zfk4y3n.cloudfront.net/bank-logos/cimb-bank.png"})
Repo.insert!(%Bank{name: "Public Bank", logo_url: "https://d3nqkn4zfk4y3n.cloudfront.net/bank-logos/public-bank.png"})
