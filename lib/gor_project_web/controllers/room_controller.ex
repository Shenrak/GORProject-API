defmodule GORprojectWeb.RoomController do
  use GORprojectWeb, :controller

  alias GORproject.Rooms
  alias GORproject.Rooms.Room

  action_fallback(GORprojectWeb.FallbackController)

  def join(conn, %{"room_id" => room_id}) do
    case Rooms.join(conn.assigns.user, room_id) do
      {status, message} ->
        if(status != :error) do
          conn
          |> put_status(status)
          |> render("joined.json", message: message)
        else
          {status, message}
        end
    end
  end

  def index(conn, _params) do
    rooms = Rooms.list_rooms()
    render(conn, "index.json", rooms: rooms)
  end

  def create(conn, %{"room" => room_params}) do
    with {:ok, %Room{} = room} <- Rooms.create_room(room_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", room_path(conn, :create))
      |> render("show.json", room: room)
    end
  end

  def show(conn, %{"id" => id}) do
    room = Rooms.get_room!(id)
    render(conn, "show.json", room: room)
  end

  def update(conn, %{"id" => id, "room" => room_params}) do
    room = Rooms.get_room!(id)

    with {:ok, %Room{} = room} <- Rooms.update_room(room, room_params) do
      render(conn, "show.json", room: room)
    end
  end

  def delete(conn, %{"id" => id}) do
    room = Rooms.get_room!(id)

    with {:ok, %Room{}} <- Rooms.delete_room(room) do
      send_resp(conn, :no_content, "")
    end
  end
end
