defmodule GarenaWeb.MerchantController do
  use GarenaWeb, :controller

  alias Garena.Component
  alias Garena.Component.Merchant

  def index(conn, _params) do
    merchants = Component.list_merchants()
    render(conn, "index.html", merchants: merchants)
  end

  def new(conn, _params) do
    changeset = Component.change_merchant(%Merchant{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"merchant" => merchant_params}) do
    case Component.create_merchant(merchant_params) do
      {:ok, merchant} ->
        conn
        |> put_flash(:info, "Merchant created successfully.")
        |> redirect(to: Routes.merchant_path(conn, :show, merchant))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    merchant = Component.get_merchant!(id)
    render(conn, "show.html", merchant: merchant)
  end

  def edit(conn, %{"id" => id}) do
    merchant = Component.get_merchant!(id)
    changeset = Component.change_merchant(merchant)
    render(conn, "edit.html", merchant: merchant, changeset: changeset)
  end

  def update(conn, %{"id" => id, "merchant" => merchant_params}) do
    merchant = Component.get_merchant!(id)

    case Component.update_merchant(merchant, merchant_params) do
      {:ok, merchant} ->
        conn
        |> put_flash(:info, "Merchant updated successfully.")
        |> redirect(to: Routes.merchant_path(conn, :show, merchant))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", merchant: merchant, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    merchant = Component.get_merchant!(id)
    {:ok, _merchant} = Component.delete_merchant(merchant)

    conn
    |> put_flash(:info, "Merchant deleted successfully.")
    |> redirect(to: Routes.merchant_path(conn, :index))
  end
end
