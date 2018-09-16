defmodule GORproject.Repo.Migrations.CreateCharacters do
  use Ecto.Migration

  def change do
    create table(:characters) do
      add :name, :string
      add :hash, :uuid
      add :characteristics, :string

      timestamps()
    end

  end
end
