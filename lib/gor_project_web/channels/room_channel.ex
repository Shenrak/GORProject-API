defmodule GORprojectWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end

  def handle_in("new_msg", %{"message" => message, "userName" => userName}, socket) do
    broadcast(socket, "new_msg", %{message: message, userName: userName})
    {:noreply, socket}
  end
end
