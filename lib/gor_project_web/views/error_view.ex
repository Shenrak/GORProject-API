defmodule GORprojectWeb.ErrorView do
  use GORprojectWeb, :view

  def render("custom.json", %{message: message}) do
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
    %{errors: %{detail: "Unused path"}}
  end

  def render("500.json", _assigns) do
    %{errors: %{detail: "Internal server error :("}}
  end

  def render("errors.json", %{code: code, message: message, changeset: changeset}) do
    %{error: %{code: code, message: message, errors: translate_errors(changeset)}}
  end

  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render("500.json", assigns)
  end
end
