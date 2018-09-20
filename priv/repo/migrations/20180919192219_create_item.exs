defmodule GORproject.Repo.Migrations.CreateItem do
  use Ecto.Migration

  def change do
    create table(:items) do
      add(:name, :string, null: false)
      add(:uuid, :uuid, null: false)
      add(:stats, :map, null: false)
      add(:character_id, references(:characters), null: false)

      timestamps()
    end

    create(unique_index(:items, [:uuid]))
  end
end
