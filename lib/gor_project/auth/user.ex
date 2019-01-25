defmodule GORproject.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias GORproject.Object.Character
  alias GORproject.Rooms.Room

  schema "users" do
    field(:login, :string)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)
    has_many(:characters, Character)
    many_to_many(:rooms, Room, join_through: "user_room")

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:login, :password])
    |> validate_required([:login, :password])
    |> unique_constraint(:login)
    # |> unique_constraint(:email, downcase: true)
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{
           valid?: true,
           changes: %{password: password}
         } = changeset
       ) do
    # change(changeset, password_hash: Bcrypt.hash_pwd_salt(password))
    change(changeset, password_hash: password)
  end

  defp put_password_hash(changeset) do
    changeset
  end
end
