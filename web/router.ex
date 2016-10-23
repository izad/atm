defmodule Atm.Router do
  use Atm.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Atm do
    pipe_through :api

    get "/", PageController, :index
    resources "/banks", BankController, only: [:index, :show]
    get "/locations/:lat/:lng", LocationController, :index
  end
end
