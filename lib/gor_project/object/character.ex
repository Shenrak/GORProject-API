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
    |> cast(attrs, [:name, :hash, :characteristics])
    |> validate_required([:name, :hash, :characteristics])
  end
end
