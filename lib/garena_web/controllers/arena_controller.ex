defmodule GarenaWeb.ArenaController do
  use GarenaWeb, :controller

  alias Garena.Component
  alias Garena.Component.{Arena, ArenaGeneratorWebWrapper}

  plug :check_arena_owner when action in [:delete]

  def index(conn, _params) do
    arenas = Component.list_arenas()
    render(conn, "index.html", arenas: arenas)
  end

  def new(conn, _params) do
    changeset = Component.change_arena(%Arena{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"arena" => arena_params}) do
    arena_params =
      if not (Map.values(arena_params) |> Enum.member?(nil)),
        do: ArenaGeneratorWebWrapper.add_arena(arena_params),
        else: arena_params

    case Component.create_arena(conn.assigns.user, arena_params) do
      {:ok, arena} ->
        conn
        |> put_flash(:info, "Arena created successfully.")
        |> redirect(to: Routes.arena_path(conn, :show, arena))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    arena = Component.get_arena!(id)
    render(conn, "show.html", arena: arena)
  end

  def delete(conn, %{"id" => id}) do
    arena = Component.get_arena!(id)
    {:ok, _arena} = Component.delete_arena(arena)

    conn
    |> put_flash(:info, "Arena deleted successfully.")
    |> redirect(to: Routes.arena_path(conn, :index))
  end

  defp check_arena_owner(conn, _params) do
    %{params: %{"id" => arena_id}} = conn

    arena = Garena.Repo.get(Arena, arena_id)

    case arena.user_id == conn.assigns.user.id do
      true ->
        conn

      false ->
        conn
        |> put_flash(:error, "You cannot do that")
        |> redirect(to: Routes.arena_path(conn, :show, arena))
        |> halt()
    end
  end
end
