defmodule Garena.Component do
  @moduledoc """
  The Component context.
  """

  import Ecto.Query, warn: false
  alias Garena.Repo

  alias Garena.Component.Arena

  @doc """
  Returns the list of arenas.

  ## Examples

      iex> list_arenas()
      [%Arena{}, ...]

  """
  def list_arenas do
    Repo.all(Arena) |> Repo.preload(:user)
  end

  @doc """
  Gets a single arena.

  Raises `Ecto.NoResultsError` if the Arena does not exist.

  ## Examples

      iex> get_arena!(123)
      %Arena{}

      iex> get_arena!(456)
      ** (Ecto.NoResultsError)

  """
  def get_arena!(id), do: Repo.get!(Arena, id) |> Repo.preload(:user)

  @doc """
  Creates a arena.

  ## Examples

      iex> create_arena(%{field: value})
      {:ok, %Arena{}}

      iex> create_arena(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_arena(user, attrs \\ %{}) do
    %Arena{}
    |> Arena.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  @doc """
  Updates a arena.

  ## Examples

      iex> update_arena(arena, %{field: new_value})
      {:ok, %Arena{}}

      iex> update_arena(arena, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_arena(%Arena{} = arena, attrs) do
    arena
    |> Arena.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Arena.

  ## Examples

      iex> delete_arena(arena)
      {:ok, %Arena{}}

      iex> delete_arena(arena)
      {:error, %Ecto.Changeset{}}

  """
  def delete_arena(%Arena{} = arena) do
    Repo.delete(arena)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking arena changes.

  ## Examples

      iex> change_arena(arena)
      %Ecto.Changeset{source: %Arena{}}

  """
  def change_arena(%Arena{} = arena) do
    Arena.changeset(arena, %{})
  end

  alias Garena.Component.Merchant

  @doc """
  Returns the list of merchants.

  ## Examples

      iex> list_merchants()
      [%Merchant{}, ...]

  """
  def list_merchants do
    Repo.all(Merchant) |> Repo.preload(:user)
  end

  @doc """
  Gets a single merchant.

  Raises `Ecto.NoResultsError` if the Merchant does not exist.

  ## Examples

      iex> get_merchant!(123)
      %Merchant{}

      iex> get_merchant!(456)
      ** (Ecto.NoResultsError)

  """
  def get_merchant!(id), do: Repo.get!(Merchant, id) |> Repo.preload(:user)

  @doc """
  Creates a merchant.

  ## Examples

      iex> create_merchant(%{field: value})
      {:ok, %Merchant{}}

      iex> create_merchant(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_merchant(user, attrs \\ %{}) do
    %Merchant{}
    |> Merchant.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  @doc """
  Updates a merchant.

  ## Examples

      iex> update_merchant(merchant, %{field: new_value})
      {:ok, %Merchant{}}

      iex> update_merchant(merchant, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_merchant(%Merchant{} = merchant, attrs) do
    merchant
    |> Merchant.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Merchant.

  ## Examples

      iex> delete_merchant(merchant)
      {:ok, %Merchant{}}

      iex> delete_merchant(merchant)
      {:error, %Ecto.Changeset{}}

  """
  def delete_merchant(%Merchant{} = merchant) do
    Repo.delete(merchant)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking merchant changes.

  ## Examples

      iex> change_merchant(merchant)
      %Ecto.Changeset{source: %Merchant{}}

  """
  def change_merchant(%Merchant{} = merchant) do
    Merchant.changeset(merchant, %{})
  end
end
