defmodule Garena.Component.Arena do
  use Ecto.Schema
  import Ecto.Changeset

  schema "arenas" do
    field :arena, :string
    field :level, :integer
    field :players, :integer
    field :rocks, :boolean, default: false
    field :width, :integer
    field :height, :integer
    belongs_to(:user, Garena.User)

    timestamps()
  end

  @doc false
  def changeset(arena, attrs) do
    arena
    |> cast(attrs, [:arena, :width, :height, :level, :players, :rocks])
    |> validate_required([:arena, :width, :height, :level, :players, :rocks])
  end
end
