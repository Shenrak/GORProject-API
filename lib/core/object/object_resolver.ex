defmodule GORproject.Object.ObjectResolver do
  alias GORproject.Object.ObjectCRUD
  alias GORproject.AuthHelper

  def all_characters_by_user_id(user_id, _info) do
    {:ok, ObjectCRUD.list_characters(user_id)}
  end

  def all_characters(_params, _info) do
    {:ok, ObjectCRUD.list_all_characters()}
  end

end
