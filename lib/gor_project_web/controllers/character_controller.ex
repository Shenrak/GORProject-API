defmodule GORprojectWeb.CharacterController do
  use GORprojectWeb, :controller

  alias GORproject.Object
  alias GORproject.Object.Character

  action_fallback(GORprojectWeb.FallbackController)

  def index(conn, _params) do
    characters = Object.list_characters(conn.assigns.user)
    render(conn, "index.json", characters: characters)
  end

  def create(conn, %{"character" => character_params}) do
    case character_params do
      %{"name" => _, "stats" => _} ->
        character_params = Map.put(character_params, "user_id", conn.assigns.user)

        with {:ok, %Character{} = character} <- Object.create_character(character_params) do
          conn
          |> put_status(:created)
          |> put_resp_header("location", character_path(conn, :show))
          |> render("show.json", character: character)
        end

      _ ->
        {:error, :bad_params}
    end
  end

  def show(conn, _) do
    uuid =
      get_req_header(conn, "uuid")
      |> hd()

    with {:ok, character} <- Object.get_character(uuid) do
      render(conn, "show.json", character: character)
    end
  rescue
    _ -> {:error, :bad_uuid}
  end

  # def update(conn, %{"id" => id, "character" => character_params}) do
  #   character = Object.get_character!(id)

  #   with {:ok, %Character{} = character} <- Object.update_character(character, character_params) do
  #     render(conn, "show.json", character: character)
  #   end
  # end

  def delete(conn, %{"id" => character_id}) do
    case Object.delete_character(character_id, conn.assigns.user) do
      {:ok, %Character{}} ->
        send_resp(conn, :no_content, "")
    end
  rescue
    _ -> {:error, :bad_id}
  end
end
