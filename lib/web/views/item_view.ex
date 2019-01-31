defmodule GORprojectWeb.ItemView do
  use GORprojectWeb, :view
  alias GORprojectWeb.ItemView

  def render("index.json", %{item: item}) do
    %{data: render_many(item, ItemView, "item.json")}
  end

  def render("show.json", %{item: item}) do
    %{data: render_one(item, ItemView, "item.json")}
  end

  def render("item.json", %{item: item}) do
    %{
      id: item.id,
      name: item.name,
      uuid: item.uuid,
      stats: item.stats,
      character_id: item.character_id
    }
  end
end
