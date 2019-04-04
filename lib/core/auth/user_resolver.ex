defmodule GORproject.Auth.UserResolver do
  alias GORproject.Auth.UserCRUD
  alias GORprojectWeb.AuthHelper

  def all(_args, _info) do
    {:ok, UserCRUD.list_users()}
  end

  def create(params, _info) do
    UserCRUD.create_user(params)
  end

  def find(%{id: id}, _info) do
    case UserCRUD.get_user(id) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  def login(%{username: username, password: password}, _info) do
    with  {:ok, user} <- AuthHelper.login_with_username_password(username, password),
          {:ok, jwt, _} <- GORproject.Guardian.encode_and_sign(user),
          {:ok, _} <- UserCRUD.store_token(user, jwt) do
      {:ok, %{token: jwt}}
    end
  end
end
