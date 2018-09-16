defmodule GORprojectWeb.CharacterController do
  use GORprojectWeb, :controller

  alias GORproject.Object
  alias GORproject.Object.Character

  action_fallback GORprojectWeb.FallbackController

  def index(conn, _params) do
    characters = Object.list_characters()
    render(conn, "index.json", characters: characters)
  end

  def create(conn, %{"character" => character_params}) do
    with {:ok, %Character{} = character} <- Object.create_character(character_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", character_path(conn, :show, character))
      |> render("show.json", character: character)
    end
  end

  def show(conn, %{"id" => id}) do
    character = Object.get_character!(id)
    render(conn, "show.json", character: character)
  end

  def update(conn, %{"id" => id, "character" => character_params}) do
    character = Object.get_character!(id)

    with {:ok, %Character{} = character} <- Object.update_character(character, character_params) do
      render(conn, "show.json", character: character)
    end
  end

  def delete(conn, %{"id" => id}) do
    character = Object.get_character!(id)
    with {:ok, %Character{}} <- Object.delete_character(character) do
      send_resp(conn, :no_content, "")
    end
  end
end
