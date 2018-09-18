defmodule GORprojectWeb.StatView do
  use GORprojectWeb, :view
  alias GORprojectWeb.CharacterView

  def render("show.json", %{character: character}) do
    %{data: render_one(character, CharacterView, "character.json")}
  end

end
