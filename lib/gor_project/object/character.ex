defmodule GORproject.Object.Character do
  use Ecto.Schema
  import Ecto.Changeset

  schema "characters" do
    field(:stats, :string)
    field(:hash, Ecto.UUID)
    field(:name, :string)

    timestamps()
  end

  @doc false
  def changeset(character, attrs) do
    character
    |> cast(attrs, [:name, :stats])
    |> validate_required([:name, :stats])
    |> generate_hash()
    |> unique_constraint(:hash)
  end

  defp generate_hash(changeset) do
    changeset =
      case changeset.data.hash do
        nil -> change(changeset, hash: Ecto.UUID.generate())
        _ -> changeset
      end

    changeset
  end
end
