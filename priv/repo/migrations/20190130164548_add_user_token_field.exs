defmodule GORproject.Repo.Migrations.AddUserTokenField do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add(:token, :text)
    end
    rename table(:users), :login, to: :username
  end
end
