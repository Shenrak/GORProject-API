defmodule GORprojectWeb.UserView do
  use GORprojectWeb, :view
  alias GORprojectWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      login: user.login,
      characters:
        render_many(user.characters, GORprojectWeb.CharacterView, "character.json", as: :character)
    }
  end

  def render("sign_in.json", %{user: user, token: token}) do
    %{data: render_one(user, UserView, "user.json"), token: token}
  end
end
