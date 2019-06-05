defmodule Garena.Repo do
  use Ecto.Repo,
    otp_app: :garena,
    adapter: Ecto.Adapters.Postgres
end
