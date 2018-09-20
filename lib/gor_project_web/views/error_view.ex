defmodule GORprojectWeb.ErrorView do
  use GORprojectWeb, :view

  def render("400.json", %{message: message}) when not is_atom(message) do
    %{errors: %{detail: message}}
  end

  def render("400.json", _assigns) do
    %{errors: %{detail: "Bad request"}}
  end

  def render("401.json", %{message: message}) do
    %{errors: %{detail: message}}
  end

  def render("404.json", %{message: message}) do
    %{errors: %{detail: message}}
  end

  def render("404.json", _assigns) do
    %{errors: %{detail: "Endpoint not found"}}
  end

  def render("500.json", _assigns) do
    %{errors: %{detail: "Internal server error :("}}
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render("500.json", assigns)
  end
end
