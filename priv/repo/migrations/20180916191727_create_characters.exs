defmodule GORproject.Repo.Migrations.CreateCharacters do
  use Ecto.Migration

  def change do
    create table(:characters) do
      add :name, :string, null: false
      add :hash, :uuid , null: false
      add :characteristics, :string, null: false

      timestamps()
    end

    create unique_index(:characters, [:hash])
  end
end
