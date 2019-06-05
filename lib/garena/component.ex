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
end
