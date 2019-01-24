defmodule GORproject.Auth.UserRoom do
  use Ecto.Schema
  import Ecto.Changeset

  alias GORproject.Auth.User
  alias GORproject.Rooms.Room

  schema "user_room" do
    has_many(:user_id, User)
    has_many(:room_id, Room)
    field(:connected, :boolean, default: false)
    field(:is_admin, :boolean, default: false)
    field(:is_creator, :boolean, default: false)
    field(:current_role, :string, default: "player")

    timestamps()
  end

  @doc false
  def changeset(userRoom, attrs) do
    userRoom
    |> cast(attrs, [:user, :room, :is_admin, :is_creator, :current_role])
    |> validate_required([:user, :room])
  end
end
