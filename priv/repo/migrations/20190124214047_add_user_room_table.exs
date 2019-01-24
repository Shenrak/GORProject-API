defmodule GORproject.Repo.Migrations.AddUserRoomTable do
  use Ecto.Migration

  def change do
    drop(table(:users_rooms))

    create table(:user_room, primary_key: false) do
      add(:room_id, references(:rooms))
      add(:user_id, references(:users))
      add(:connected, :boolean)
      add(:is_admin, :boolean)
      add(:is_creator, :boolean)
      add(:current_role, :string, size: 20)

      timestamps
    end
  end
end
