defmodule Garena.TestHelpers do
  alias Garena.{Component, Repo, User}

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


  def generated_arena_fixture(attrs \\ %{}) do
    user = user_fixture()

    arena_params =
      attrs
      |> Enum.into(%{
        arena: "XWW\nXOO\nOPX",
        level: 2,
        players: 1,  
        rocks: true,
        width: 3,
        height: 3
      })

    {:ok, arena} = Component.create_arena(user, arena_params)

    arena
  end
end
