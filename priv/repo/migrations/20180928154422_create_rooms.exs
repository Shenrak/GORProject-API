defmodule GORproject.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add(:name, :string)
      add(:depth, :integer)
      add(:description, :string)

      add(:father_id, references: :rooms, null: false)

      timestamps()
    end

    create table(:users_rooms, primary_key: false) do
      add(:room_id, references(:rooms))
      add(:user_id, references(:users))
    end
  end
end
