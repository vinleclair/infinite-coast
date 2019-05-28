ExUnit.start()
ExUnit.configure(exclude: :pending, trace: true)
Ecto.Adapters.SQL.Sandbox.mode(Garena.Repo, :manual)

