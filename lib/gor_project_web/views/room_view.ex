defmodule GORprojectWeb.RoomView do
  use GORprojectWeb, :view
  alias GORprojectWeb.RoomView

  def render("index.json", %{rooms: rooms}) do
    %{data: render_many(rooms, RoomView, "room.json")}
  end

  def render("show.json", %{room: room}) do
    %{data: render_one(room, RoomView, "room.json")}
  end

  def render("room.json", %{room: room}) do
    %{
      id: room.id,
      name: room.name,
      users: render_many(room.users, GORprojectWeb.UserView, "user.json", as: :users),
      # father: render_one(room.father, GORprojectWeb.RoomView, "room.json", as: :room),
      # children: render_many(room.children, GORprojectWeb.RoomView, "room.json", as: :room),
      description: room.description,
      father_id: room.father_id,
      public: room.public
    }
  end

  def render("joined.json", %{message: message})do
    %{
      message: message
    }
  end

  def render("current.json", %{room: room})do
    %{
      room: room
    }
  end
end
