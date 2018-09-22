defmodule GORprojectWeb.UserController do
  use GORprojectWeb, :controller

  alias GORproject.Auth
  alias GORproject.Auth.User

  action_fallback GORprojectWeb.FallbackController

  def sign_in(conn, %{"login" => login, "password" => password}) do
    case GORproject.Auth.authenticate_user(login, password) do
      {:ok, user} ->
        token = Phoenix.Token.sign(GORprojectWeb.Endpoint, "user salt", user.id)
        # Phoenix.Token.verify(GORproject.Endpoint, "user salt", token, max_age: 86400)
        conn
        |> put_status(:ok)
        |> render(GORprojectWeb.UserView, "sign_in.json", user: user, token: token)

      {:error, message} ->
        conn
        |> put_status(:unauthorized)
        |> render(GORprojectWeb.ErrorView, "401.json", message: message)
    end
  end

  def index(conn, _params) do
    users = Auth.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Auth.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Auth.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Auth.get_user!(id)

    with {:ok, %User{} = user} <- Auth.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Auth.get_user!(id)
    with {:ok, %User{}} <- Auth.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
