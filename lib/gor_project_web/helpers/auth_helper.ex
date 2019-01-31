defmodule GORproject.AuthHelper do
  @moduledoc false

  # import Comeonin.Bcrypt, only: [checkpw: 2]
  alias GORproject.Repo
  alias GORproject.Auth.User

  def login_with_username_password(username, given_pass) do
    user = Repo.get_by(User, username: String.downcase(username))

    cond do
      user && Comeonin.Bcrypt.checkpw(given_pass, user.password_hash) ->
        {:ok, user}

      user ->
        {:error, "Incorrect login credentials"}

      true ->
        {:error, :"User not found"}
    end
  end
end
