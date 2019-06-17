defmodule Garena.ComponentTest do
  use Garena.DataCase

  alias Garena.Component

  describe "arenas" do
    alias Garena.Component.Arena

    @valid_attrs %{
      arena: "some arena",
      level: 42,
      players: 42,
      rocks: true,
      width: 3,
      height: 3
    }
    @update_attrs %{
      arena: "some updated arena",
      level: 43,
      players: 43,
      rocks: false,
      width: 4,
      height: 4
    }
    @invalid_attrs %{
      arena: nil,
      level: nil,
      players: nil,
      rocks: nil,
      width: nil,
      height: nil
    }

    def arena_fixture(attrs \\ %{}) do
      user = user_fixture()

      arena_params =
        attrs
        |> Enum.into(@valid_attrs)

      {:ok, arena} = Component.create_arena(user, arena_params)

      arena
    end

    test "list_arenas/0 returns all arenas" do
      arena = arena_fixture()
      assert Component.list_arenas() == [arena]
    end

    test "get_arena!/1 returns the arena with given id" do
      arena = arena_fixture()
      assert Component.get_arena!(arena.id) == arena
    end

    test "create_arena/2 with valid data creates a arena" do
      user = user_fixture()

      assert {:ok, %Arena{} = arena} = Component.create_arena(user, @valid_attrs)
      assert arena.arena == "some arena"
      assert arena.level == 42
      assert arena.players == 42
      assert arena.rocks == true
      assert arena.width == 3
      assert arena.height == 3
    end

    test "create_arena/2 with invalid data returns error changeset" do
      user = user_fixture()

      assert {:error, %Ecto.Changeset{}} = Component.create_arena(user, @invalid_attrs)
    end

    test "update_arena/2 with valid data updates the arena" do
      arena = arena_fixture()
      assert {:ok, %Arena{} = arena} = Component.update_arena(arena, @update_attrs)
      assert arena.arena == "some updated arena"
      assert arena.level == 43
      assert arena.players == 43
      assert arena.rocks == false
      assert arena.width == 4
      assert arena.height == 4
    end

    test "update_arena/2 with invalid data returns error changeset" do
      arena = arena_fixture()
      assert {:error, %Ecto.Changeset{}} = Component.update_arena(arena, @invalid_attrs)
      assert arena == Component.get_arena!(arena.id)
    end

    test "delete_arena/1 deletes the arena" do
      arena = arena_fixture()
      assert {:ok, %Arena{}} = Component.delete_arena(arena)
      assert_raise Ecto.NoResultsError, fn -> Component.get_arena!(arena.id) end
    end

    test "change_arena/1 returns a arena changeset" do
      arena = arena_fixture()
      assert %Ecto.Changeset{} = Component.change_arena(arena)
    end
  end

  describe "merchants" do
    alias Garena.Component.Merchant

    @valid_attrs %{coins: "some coins", items: "some items", level: "2", name: "some name"}
    @update_attrs %{coins: "some updated coins", items: "some updated items", level: "3", name: "some updated name"}
    @invalid_attrs %{coins: nil, items: nil, level: nil, name: nil}

    def merchant_fixture(attrs \\ %{}) do
      user = user_fixture()
      
      merchant_params =
        attrs
        |> Enum.into(@valid_attrs)

      {:ok, merchant} = Component.create_merchant(user, merchant_params)

      merchant
    end

    test "list_merchants/0 returns all merchants" do
      merchant = merchant_fixture()
      assert Component.list_merchants() == [merchant]
    end

    test "get_merchant!/1 returns the merchant with given id" do
      merchant = merchant_fixture()
      assert Component.get_merchant!(merchant.id) == merchant
    end

    test "create_merchant/1 with valid data creates a merchant" do
      user = user_fixture() 

      assert {:ok, %Merchant{} = merchant} = Component.create_merchant(user, @valid_attrs)
      assert merchant.coins == "some coins"
      assert merchant.items == "some items"
      assert merchant.level == "2"
      assert merchant.name == "some name"
    end

    test "create_merchant/1 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Component.create_merchant(user, @invalid_attrs)
    end

    test "update_merchant/2 with valid data updates the merchant" do
      merchant = merchant_fixture()
      assert {:ok, %Merchant{} = merchant} = Component.update_merchant(merchant, @update_attrs)
      assert merchant.coins == "some updated coins"
      assert merchant.items == "some updated items"
      assert merchant.level == "3"
      assert merchant.name == "some updated name"
    end

    test "update_merchant/2 with invalid data returns error changeset" do
      merchant = merchant_fixture()
      assert {:error, %Ecto.Changeset{}} = Component.update_merchant(merchant, @invalid_attrs)
      assert merchant == Component.get_merchant!(merchant.id)
    end

    test "delete_merchant/1 deletes the merchant" do
      merchant = merchant_fixture()
      assert {:ok, %Merchant{}} = Component.delete_merchant(merchant)
      assert_raise Ecto.NoResultsError, fn -> Component.get_merchant!(merchant.id) end
    end

    test "change_merchant/1 returns a merchant changeset" do
      merchant = merchant_fixture()
      assert %Ecto.Changeset{} = Component.change_merchant(merchant)
    end
  end
end
