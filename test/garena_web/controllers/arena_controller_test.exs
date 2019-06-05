defmodule GarenaWeb.ArenaControllerTest do
  use GarenaWeb.ConnCase

  @create_attrs %{
    arena: "some arena",
    level: 42,
    players: 42,
    rocks: true,
    width: 3,
    height: 3,
  }
  @update_attrs %{
    arena: "some updated arena",
    level: 43,
    players: 43,
    rocks: false,
    width: 4,
    height: 4,
  }
  @invalid_attrs %{
    arena: nil,
    level: nil,
    players: nil,
    rocks: nil,
    width: nil,
    height: nil,
  }

  describe "index" do
    test "lists all arenas", %{conn: conn} do
      conn = get(conn, Routes.arena_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Arenas"
    end
  end

  describe "new arena" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.arena_path(conn, :new))
      assert html_response(conn, 200) =~ "type=\"submit\">Generate Arena</button>"  
    end
  end

  describe "create arena" do
    test "redirects to show when data is valid", %{conn: conn} do
      user = user_fixture()

      conn =
        conn
        |> assign(:user, user)
        |> post(Routes.arena_path(conn, :create), arena: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.arena_path(conn, :show, id)

      assert html_response(conn, 302) =~
               "<html><body>You are being <a href=\"/arenas/#{id}\">redirected</a>.</body></html>"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      user = user_fixture()

      conn =
        conn
        |> assign(:user, user)
        |> post(Routes.arena_path(conn, :create), arena: @invalid_attrs)

      assert html_response(conn, 200) =~ "type=\"submit\">Generate Arena</button>"
    end
  end

  describe "edit arena" do
    test "renders form for editing chosen arena", %{conn: conn} do
      arena = generated_arena_fixture()
      conn = get(conn, Routes.arena_path(conn, :edit, arena))
      assert html_response(conn, 200) =~ "Edit Arena"
    end
  end

  describe "update arena" do
    test "redirects when data is valid", %{conn: conn} do
      arena = generated_arena_fixture()
      conn = put(conn, Routes.arena_path(conn, :update, arena), arena: @update_attrs)
      assert redirected_to(conn) == Routes.arena_path(conn, :show, arena)

      conn = get(conn, Routes.arena_path(conn, :show, arena))
      assert html_response(conn, 200) =~ "some updated arena"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      arena = generated_arena_fixture()
      conn = put(conn, Routes.arena_path(conn, :update, arena), arena: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Arena"
    end
  end

  describe "delete arena" do
    test "deletes chosen arena", %{conn: conn} do
      arena = generated_arena_fixture()

      conn = delete(conn, Routes.arena_path(conn, :delete, arena))
      assert redirected_to(conn) == Routes.arena_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.arena_path(conn, :show, arena))
      end
    end
  end
end
