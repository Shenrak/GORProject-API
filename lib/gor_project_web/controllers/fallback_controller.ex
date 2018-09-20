defmodule GORprojectWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use GORprojectWeb, :controller

  def call(conn, {:error, changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(GORprojectWeb.ChangesetView, "error.json", changeset: changeset)
  end

  def call(conn, {:error, :bad_request}) do
    conn
    |> put_status(:bad_request)
    |> render(GORprojectWeb.ErrorView, :"400")
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> render(GORprojectWeb.ErrorView, :"404")
  end

  def call(conn, {:error, message}) do
    conn
    |> put_status(:not_found)
    |> render(GORprojectWeb.ErrorView, :"404", message: message)
  end
end
