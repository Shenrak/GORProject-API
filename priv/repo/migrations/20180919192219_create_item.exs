defmodule GORproject.Repo.Migrations.CreateItem do
  use Ecto.Migration

  def change do
    create table(:item) do
      add :name, :string
      add :hash, :uuid
      add :stats, :string

      timestamps()
    end

  end
end
