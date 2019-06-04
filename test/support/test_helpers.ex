defmodule Garena.TestHelpers do
  alias Garena.{Repo, User}

  def user_fixture(attrs \\ %{}) do
    params =
      attrs
      |> Enum.into(%{
        first_name: "Matt",
        last_name: "Mercer",
        email: "master_dm_#{System.unique_integer([:positive])}@example.com",
        token: "2u9dfh7979hfd",
        provider: "google"
      })

    {:ok, user} =
      User.changeset(%User{}, params)
      |> Repo.insert()

    user
  end
end
