defmodule GORproject.Object.Character do
  use Ecto.Schema
  import Ecto.Changeset


  schema "characters" do
    field :characteristics, :string
    field :hash, Ecto.UUID
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(character, attrs) do
    character
    |> cast(attrs, [:name, :characteristics])
    |> validate_required([:name, :characteristics])
    |> generate_hash()
    |> unique_constraint(:hash)
  end

  def generate_hash(changeset) when changeset.hash == nil do
    change(changeset, hash: Ecto.UUID.generate())
  end
  def generate_hash(changeset), do: changeset
end
