defmodule GarenaWeb.Router do
  use GarenaWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Garena.Plugs.SetUser
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", GarenaWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/auth", GarenaWeb do
    pipe_through :browser

    get "/signout", SessionController, :delete 
    get "/:provider", SessionController, :request
    get "/:provider/callback", SessionController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", GarenaWeb do
  #   pipe_through :api
  # end
end
