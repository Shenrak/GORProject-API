defmodule GORproject.Object.Item do
  use Ecto.Schema
  import Ecto.Changeset


  schema "item" do
    field :hash, Ecto.UUID
    field :name, :string
    field :stats, :string

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
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
