defmodule GORproject.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias GORproject.Object.Character
  alias GORproject.Rooms.Room

  schema "users" do
    field(:username, :string)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)
    field(:token, :string)
    has_many(:characters, Character)
    many_to_many(:rooms, Room, join_through: "user_room")

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
    |> unique_constraint(:username)
    # |> unique_constraint(:email, downcase: true)
    |> put_password_hash()
  end

  def store_token_changeset(user, attrs) do
    user
    |> cast(attrs, [:token])
  end

  defp put_password_hash(
        %Ecto.Changeset{
          valid?: true,
          changes: %{password: password}
        } = changeset
      ) do
    change(changeset, password_hash: Comeonin.Bcrypt.hashpwsalt(password))
    # change(changeset, password_hash: password)
  end

  defp put_password_hash(changeset) do
    changeset
  end
end
