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
    %{id: user.id, login: user.login}
  end

  def render("sign_in.json", %{user: user, token: token}) do
    %{
      data: %{
        user: %{
          id: user.id,
          login: user.login
        },
        token: token
      }
    }
  end
end
