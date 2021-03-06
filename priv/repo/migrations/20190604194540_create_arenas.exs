defmodule Garena.Repo.Migrations.CreateArenas do
  use Ecto.Migration

  def change do
    create table(:arenas) do
      add :arena, :text
      add :width, :integer
      add :height, :integer
      add :level, :integer
      add :players, :integer
      add :rocks, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:arenas, [:user_id])
  end
end
