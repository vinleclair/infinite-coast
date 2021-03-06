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

  def generated_arena_fixture(%Garena.User{} = user, attrs \\ %{}) do
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

  def generate_merchant_fixture(%Garena.User{} = user, attrs \\ %{}) do
    merchant_params =
      attrs
      |> Enum.into(%{
        coins: "30 gp",
        level: "2",
        items: "Item Name: Tinderbox\nPrice: 5 sp",
        name: "Divrash"
      })

    {:ok, merchant} = Component.create_merchant(user, merchant_params)

    merchant
  end

  def generate_random_arena do
    width = Enum.random(6..24)
    height = Enum.random(6..24)
    ArenaGenerator.generate_empty_arena(width, height)
  end
end
