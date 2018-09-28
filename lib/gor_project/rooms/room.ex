defmodule GORproject.Rooms.Room do
  use Ecto.Schema
  import Ecto.Changeset

  alias GORproject.Rooms.Room
  alias GORproject.Auth.User

  schema "rooms" do
    field(:depth, :integer)
    field(:name, :string)
    field(:description, :string)
    many_to_many(:users, User, join_through: "users_rooms")
    has_many(:children, Room)
    belongs_to(:father, Room, foreign_key: :father_id)

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:name, :depth, :description])
    |> validate_required([:name, :depth])
  end
end
