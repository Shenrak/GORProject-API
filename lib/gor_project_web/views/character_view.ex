defmodule GORprojectWeb.CharacterView do
  use GORprojectWeb, :view
  alias GORprojectWeb.CharacterView

  def render("index.json", %{characters: characters}) do
    %{data: render_many(characters, CharacterView, "character.json")}
  end

  def render("show.json", %{character: character}) do
    %{data: render_one(character, CharacterView, "character.json")}
  end

  def render("character.json", %{character: character}) do
    %{id: character.id, name: character.name, uuid: character.uuid, stats: character.stats}
  end
end
