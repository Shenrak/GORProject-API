defmodule GORproject.Object.Character do
  use Ecto.Schema
  import Ecto.Changeset
  alias GORproject.Object.Item
  alias GORproject.Auth.User

  schema "characters" do
    field(:stats, {:array, :map})
    field(:uuid, Ecto.UUID)
    field(:name, :string)
    has_many(:items, Item)
    belongs_to(:user, User)

    timestamps()
  end

  @doc false
  def changeset(character, attrs) do
    character
    |> cast(attrs, [:name, :stats, :user_id])
    |> foreign_key_constraint(:user_id)
    |> validate_required([:name, :stats, :user_id])
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
