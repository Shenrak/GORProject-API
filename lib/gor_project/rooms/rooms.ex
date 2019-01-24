defmodule GORproject.Rooms do
  @moduledoc """
  The Rooms context.
  """

  import Ecto.Query, warn: false
  alias GORproject.Repo

  alias GORproject.Rooms.Room

  def join(user_id, room_id) do
    room =
      from(r in Room, where: r.id == ^room_id, select: r)
      |> Repo.all()
      |> hd()

    if(room.public) do
      {:ok, "You have been allowed"}
    else
      {:unauthorized, "The game master didn't allow you"}
    end
  rescue
    _ -> {:error, :bad_params}
  end

  def getCurrent(user_id) do
    room =
      from(r in Room, where: r.id == ^room_id, select: r)
      |> Repo.all()
      |> hd()

    if(room.public) do
      {:ok, "You have been allowed"}
    else
      {:unauthorized, "The game master didn't allow you"}
    end
  rescue
    _ -> {:error, :bad_params}
  end

  @doc """
  Returns the list of rooms.

  ## Examples

      iex> list_rooms()
      [%Room{}, ...]

  """
  def list_rooms do
    Repo.all(Room)
    |> Repo.preload(:users)
    # |> Repo.preload(:children)
    # |> Repo.preload(:father)
  end

  @doc """
  Gets a single room.

  Raises `Ecto.NoResultsError` if the Room does not exist.

  ## Examples

      iex> get_room!(123)
      %Room{}

      iex> get_room!(456)
      ** (Ecto.NoResultsError)

  """
  def get_room!(id), do: Repo.get!(Room, id)

  @doc """
  Creates a room.

  ## Examples

      iex> create_room(%{field: value})
      {:ok, %Room{}}

      iex> create_room(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_room(attrs \\ %{}) do
    %Room{children: [], father: nil, users: []}
    |> Room.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a room.

  ## Examples

      iex> update_room(room, %{field: new_value})
      {:ok, %Room{}}

      iex> update_room(room, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_room(%Room{} = room, attrs) do
    room
    |> Room.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Room.

  ## Examples

      iex> delete_room(room)
      {:ok, %Room{}}

      iex> delete_room(room)
      {:error, %Ecto.Changeset{}}

  """
  def delete_room(%Room{} = room) do
    Repo.delete(room)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking room changes.

  ## Examples

      iex> change_room(room)
      %Ecto.Changeset{source: %Room{}}

  """
  def change_room(%Room{} = room) do
    Room.changeset(room, %{})
  end
end
