defmodule Garena.Component.Merchant do
  use Ecto.Schema
  use Rummage.Ecto
  import Ecto.Changeset

  schema "merchants" do
    field :coins, :string
    field :items, :string
    field :level, :string
    field :name, :string
    belongs_to(:user, Garena.User)

    timestamps()
  end

  @doc false
  def changeset(merchant, attrs) do
    merchant
    |> cast(attrs, [:name, :level, :coins, :items])
    |> validate_required([:name, :level, :coins, :items])
  end
end
