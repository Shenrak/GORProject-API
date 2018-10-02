defmodule GORproject.Repo.Migrations.AddPublicFlagRooms do
  use Ecto.Migration

  def change do
    alter table(:rooms) do
      add(:public, :boolean, default: true, null: false)
    end
  end
end
