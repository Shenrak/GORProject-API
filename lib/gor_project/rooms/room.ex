defmodule GORproject.Rooms.Room do
  use Ecto.Schema
  import Ecto.Changeset

  alias GORproject.Rooms.Room
  alias GORproject.Auth.User

  schema "rooms" do
    field(:depth, :integer)
    field(:name, :string)
    field(:description, :string)
    field(:public, :boolean)
    has_many(:children, Room, foreign_key: :father_id)
    belongs_to(:father, Room, foreign_key: :father_id)
    many_to_many(:users, User, join_through: "user_room")

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:name, :depth, :description, :public, :father_id])
    |> foreign_key_constraint(:father_id)
    |> validate_required([:name, :depth, :public])
  end
end
