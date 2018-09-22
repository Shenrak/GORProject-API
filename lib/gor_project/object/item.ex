defmodule GORproject.Object.Item do
  use Ecto.Schema
  import Ecto.Changeset
  alias GORproject.Object.Character

  schema "items" do
    field(:uuid, Ecto.UUID)
    field(:name, :string)
    field(:stats, :map)
    belongs_to(:character, Character)

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :stats, :character_id])
    |> validate_required([:name, :stats, :character_id])
    |> generate_uuid()
    |> unique_constraint(:uuid)
  end

  defp generate_uuid(changeset) do
    changeset =
      case changeset.data.uuid do
        nil -> change(changeset, uuid: Ecto.UUID.generate())
        _ -> changeset
      end

    changeset
  end
end
