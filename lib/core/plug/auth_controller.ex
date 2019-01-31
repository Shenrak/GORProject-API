defmodule GORproject.AuthController do
  use GORprojectWeb, :controller

  def unauthenticated(conn, _params) do
    conn
    |> put_status(401)
    |> json(%{error: "Unauthenticated!"})
  end
end
