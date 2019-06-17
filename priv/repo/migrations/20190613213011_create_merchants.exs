defmodule Garena.Repo.Migrations.CreateMerchants do
  use Ecto.Migration

  def change do
    create table(:merchants) do
      add :name, :string
      add :level, :string
      add :coins, :string
      add :items, :text
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:merchants, [:user_id])
  end
end
