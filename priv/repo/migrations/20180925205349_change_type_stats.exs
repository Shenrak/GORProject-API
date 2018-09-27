defmodule GORproject.Repo.Migrations.ChangeTypeStats do
  use Ecto.Migration

  def change do
    alter table(:items) do
      remove(:stats)
      add(:stats, {:array, :map})
    end

    alter table(:characters) do
      remove(:stats)
      add(:stats, {:array, :map})
    end
  end
end
