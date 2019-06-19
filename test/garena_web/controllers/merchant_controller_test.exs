defmodule GarenaWeb.MerchantControllerTest do
  use GarenaWeb.ConnCase

  @create_attrs %{level: "2"}
  @update_attrs %{
    level: "3"
  }
  @invalid_attrs %{level: nil}

  describe "index" do
    test "lists all merchants", %{conn: conn} do
      conn = get(conn, Routes.merchant_path(conn, :index))
      assert html_response(conn, 200) =~ "Merchants"
    end
  end

  describe "new merchant" do
    test "renders form", %{conn: conn} do
      user = user_fixture()

      conn =
        conn
        |> assign(:user, user)
        |> get(Routes.merchant_path(conn, :new))

      assert html_response(conn, 200) =~ "type=\"submit\">Generate Merchant</button>"
    end
  end

  describe "create merchant" do
    test "redirects to show when data is valid", %{conn: conn} do
      user = user_fixture()

      conn =
        conn
        |> assign(:user, user)
        |> post(Routes.merchant_path(conn, :create), merchant: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.merchant_path(conn, :show, id)

      assert html_response(conn, 302) =~
               "<html><body>You are being <a href=\"/merchants/#{id}\">redirected</a>.</body></html>"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      user = user_fixture()

      conn =
        conn
        |> assign(:user, user)
        |> post(Routes.merchant_path(conn, :create), merchant: @invalid_attrs)

      assert html_response(conn, 200) =~ "type=\"submit\">Generate Merchant</button>"
    end
  end

  describe "edit merchant" do
    test "renders form for editing chosen merchant", %{conn: conn} do
      user = user_fixture()
      merchant = generate_merchant_fixture(user) 

      conn = get(conn, Routes.merchant_path(conn, :edit, merchant))
      assert html_response(conn, 200) =~ "Edit Merchant"
    end
  end

  describe "update merchant" do
    test "redirects when data is valid", %{conn: conn, merchant: merchant} do
      user = user_fixture()
      merchant = generate_merchant_fixture(user) 
      conn = put(conn, Routes.merchant_path(conn, :update, merchant), merchant: @update_attrs)
      assert redirected_to(conn) == Routes.merchant_path(conn, :show, merchant)

      conn = get(conn, Routes.merchant_path(conn, :show, merchant))
      assert html_response(conn, 200) =~ "some updated coins"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      user = user_fixture()
      merchant = generate_merchant_fixture(user) 
      conn = put(conn, Routes.merchant_path(conn, :update, merchant), merchant: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Merchant"
    end
  end

  describe "delete merchant" do
    test "deletes chosen merchant", %{conn: conn} do
      user = user_fixture()
      merchant = generate_merchant_fixture(user)

      conn =
        conn
        |> assign(:user, user)
        |> delete(Routes.merchant_path(conn, :delete, merchant))

      assert redirected_to(conn) == Routes.merchant_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.merchant_path(conn, :show, merchant))
      end
    end

    test "cannot delete chosen merchant", %{conn: conn} do
      user1 = user_fixture()
      user2 = user_fixture()
      merchant = generate_merchant_fixture(user2)

      conn =
        conn
        |> assign(:user, user1)
        |> delete(Routes.merchant_path(conn, :delete, merchant))

      assert redirected_to(conn) == Routes.merchant_path(conn, :show, merchant)

      assert html_response(conn, 302) =~
               "<html><body>You are being <a href=\"/merchants/#{merchant.id}\">redirected</a>.</body></html>"
    end
  end

  describe "show merchant" do
    test "shows chosen merchant", %{conn: conn} do
      user = user_fixture()
      merchant = generate_merchant_fixture(user)
      conn = get(conn, Routes.merchant_path(conn, :show, merchant))

      assert html_response(conn, 200) =~ merchant.name
    end
  end
end
