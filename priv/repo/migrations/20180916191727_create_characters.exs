defmodule GORproject.Repo.Migrations.CreateCharacters do
  use Ecto.Migration

  def change do
    create table(:characters) do
      add :name, :string, null: false
      add :uuid, :uuid , null: false
      add :stats, :string, null: false

      timestamps()
    end

    create unique_index(:characters, [:uuid])
  end
end
