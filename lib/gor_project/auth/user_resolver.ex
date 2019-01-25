defmodule GORproject.Auth.UserResolver do
  alias GORproject.Auth

  def all(_args, _infos) do
    {:ok, Auth.list_users()}
  end

  def create(params, _infos) do
    Auth.create_user(params)
  end

  def find(%{id: id}, _infos) do
    case Auth.get_user(id) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end
