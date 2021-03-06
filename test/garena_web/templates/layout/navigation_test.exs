defmodule GarenaWeb.NavigationTest do
  use GarenaWeb.ConnCase

  test "shows a sign in with Google link when not signed in", %{conn: conn} do
    conn = get(conn, "/")

    assert html_response(conn, 200) =~ "Sign in with Google"
  end

  test "shows a sign out link when signed in", %{conn: conn} do
    user = user_fixture()

    conn =
      conn
      |> assign(:user, user)
      |> get("/")

    assert html_response(conn, 200) =~ "Sign out"
  end

  test "shows a link to the arenas index", %{conn: conn} do
    conn = get(conn, "/")

    assert html_response(conn, 200) =~ "href=\"/arenas\">Arenas</a>"
  end

  test "shows a link to generate an arena for a signed in user", %{conn: conn} do
    user = user_fixture()

    conn =
      conn
      |> assign(:user, user)
      |> get("/")

    assert html_response(conn, 200) =~ "href=\"/arenas/new\">Generate Arena</a>"
  end

  test "shows a link to the merchants index", %{conn: conn} do
    conn = get(conn, "/")

    assert html_response(conn, 200) =~ "href=\"/merchants\">Merchants</a>"
  end

  test "shows a link to generate a merchant for a signed in user", %{conn: conn} do
    user = user_fixture()

    conn =
      conn
      |> assign(:user, user)
      |> get("/")

    assert html_response(conn, 200) =~ "href=\"/merchants/new\">Generate Merchant</a>"
  end
end
