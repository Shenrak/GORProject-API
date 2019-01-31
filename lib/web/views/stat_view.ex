defmodule GORprojectWeb.StatView do
  use GORprojectWeb, :view
  alias GORprojectWeb.CharacterView
  alias GORprojectWeb.ItemView

  def render("show.json", %{character: character}) do
    %{data: render_one(character, CharacterView, "character.json")}
  end

  def render("show.json", %{item: item}) do
    %{data: render_one(item, ItemView, "item.json")}
  end
end
