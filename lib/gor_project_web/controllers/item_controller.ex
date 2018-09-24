defmodule GORprojectWeb.ItemController do
  use GORprojectWeb, :controller

  alias GORproject.Object
  alias GORproject.Object.Item

  action_fallback(GORprojectWeb.FallbackController)

  def index(conn, _params) do
    item = Object.list_item()
    render(conn, "index.json", item: item)
  end

  def create(conn, %{"item" => item_params}) do
    case item_params do
      %{"name" => _, "stats" => _, "character_id" => _} ->
        with {:ok, %Item{} = item} <- Object.create_item(item_params) do
          conn
          |> put_status(:created)
          |> put_resp_header("location", item_path(conn, :show))
          |> render("show.json", item: item)
        end

      _ ->
        {:error, :bad_params}
    end
  end

  def show(conn, _) do
    uuid =
      get_req_header(conn, "uuid")
      |> hd()

    with {:ok, item} <- Object.get_item(uuid) do
      render(conn, "show.json", item: item)
    end
  rescue
    _ -> {:error, :bad_uuid}
  end

  # def update(conn, %{"id" => id, "item" => item_params}) do
  #   item = Object.get_item!(id)

  #   with {:ok, %Item{} = item} <- Object.update_item(item, item_params) do
  #     render(conn, "show.json", item: item)
  #   end
  # end

  def delete(conn, %{"id" => id}) do

    case Object.delete_item(id, conn.assigns.user) do
      {:ok, %Item{}} ->
        send_resp(conn, :no_content, "")
    end
  end
end
