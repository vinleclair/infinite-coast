# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :garena,
  ecto_repos: [Garena.Repo]

# Configures the endpoint
config :garena, GarenaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "qGNKF0MYkHHJqhBbPODADYyBhbeM9VCIx2/EzLmPhA6KJeOrJ8UJli2cFkB4FU07",
  render_errors: [view: GarenaWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Garena.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure Rummage Phoenix
config :rummage_ecto, Rummage.Ecto,
  default_repo: Garena.Repo,
  default_per_page: 5

# Configure Google OAuth
config :ueberauth, Ueberauth,
  providers: [
    google: {Ueberauth.Strategy.Google, [default_scope: "email profile plus.me"]}
  ]

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
