defmodule GORprojectWeb.CharacteristicController do
  use GORprojectWeb, :controller

  alias GORproject.Object
  alias GORproject.Object.Character

  action_fallback(GORprojectWeb.FallbackController)

  def create(conn, %{"hash" => hash, "characteristic" => characteristic}) do
    with {:ok, %Character{} = character} <- Object.add_characteristic(hash, characteristic) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", character_path(conn, :show, character))
      |> render("show.json", character: character)
    end
  end
end
