defmodule GORproject.Object.Character do
  use Ecto.Schema
  import Ecto.Changeset
  alias GORproject.Object.Item

  schema "characters" do
    field(:stats, :map)
    field(:uuid, Ecto.UUID)
    field(:name, :string)
    has_many(:items, Item)

    timestamps()
  end

  @doc false
  def changeset(character, attrs) do
    character
    |> cast(attrs, [:name, :stats])
    |> validate_required([:name, :stats])
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
