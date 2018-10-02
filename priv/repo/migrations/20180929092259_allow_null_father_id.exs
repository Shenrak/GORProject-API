defmodule GORproject.Repo.Migrations.AllowNullFatherId do
  use Ecto.Migration

  def change do
    alter table(:rooms) do
      remove(:father_id)
      add(:father_id, references(:rooms), null: true)
    end
  end
end
