defmodule GORproject.Repo.Migrations.UserHaveManyCharacter do
  use Ecto.Migration

  def change do
    alter table(:characters) do
      add(:user_id, references(:users), null: false)
    end
  end
end
