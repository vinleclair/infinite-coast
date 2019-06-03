defmodule GarenaWeb.PageControllerTest do
  use GarenaWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Garena!"
  end
end
