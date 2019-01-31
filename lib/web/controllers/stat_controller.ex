defmodule GORprojectWeb.StatController do
  use GORprojectWeb, :controller

  alias GORproject.Object
  alias GORproject.Object.Character
  alias GORproject.Object.Item

  action_fallback(GORprojectWeb.FallbackController)

  def create(conn, %{"uuid" => uuid, "stat" => stat}) do
    case Object.add_stat(uuid, stat) do
      {:ok, %Character{} = character} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", character_path(conn, :show))
        |> render("show.json", character: character)

      {:ok, %Item{} = item} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", item_path(conn, :show))
        |> render("show.json", item: item)
    end
  end

  def delete(conn, %{"uuid" => uuid, "stat" => stat}) do
    result = Object.delete_stat(uuid, conn.assigns.user, stat)

    case result do
      {:ok, %Character{}} ->
        send_resp(conn, :no_content, "")

      {:ok, %Item{}} ->
        send_resp(conn, :no_content, "")
    end
  # rescue
  #   _ -> {:error, :bad_uuid}
  end
end
