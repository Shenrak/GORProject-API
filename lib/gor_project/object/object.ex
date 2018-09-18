defmodule GORproject.Object do
  @moduledoc """
  The Object context.
  """

  import Ecto.Query, only: [from: 2]
  alias GORproject.Repo

  alias GORproject.Object.Character

  @doc """
  Returns the list of characters.

  ## Examples

      iex> list_characters()
      [%Character{}, ...]

  """
  def list_characters do
    Repo.all(Character)
  end

  @doc """
  Gets a single character.

  Raises `Ecto.NoResultsError` if the Character does not exist.

  ## Examples

      iex> get_character!(123)
      %Character{}

      iex> get_character!(456)
      ** (Ecto.NoResultsError)

  """
  def get_character!(id), do: Repo.get!(Character, id)

  def add_stat(uuid, newStat) do
    query =
      from(
        c in Character,
        where: c.uuid == ^uuid,
        select: c
      )

    # add item management
    case Repo.one(query) do
      {:ok, character} ->
        stats = Poison.decode!(character.stats)

        str =
          Map.put(stats, newStat["name"], newStat["value"])
          |> Poison.encode!()

        Character.changeset(character, %{stats: str})
        |> Repo.update()

      nil ->
        {:error, "No character found for the given uuid"}
    end
  end

  @doc """
  Creates a character.

  ## Examples

      iex> create_character(%{field: value})
      {:ok, %Character{}}

      iex> create_character(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_character(attrs \\ %{}) do
    stats =
      case attrs["stats"] do
        "{}" -> attrs["stats"]
        _ -> Poison.encode!(attrs["stats"])
      end

    attrs = %{attrs | "stats" => stats}

    %Character{}
    |> Character.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a character.

  ## Examples

      iex> update_character(character, %{field: new_value})
      {:ok, %Character{}}

      iex> update_character(character, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_character(%Character{} = character, attrs) do
    character
    |> Character.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Character.

  ## Examples

      iex> delete_character(character)
      {:ok, %Character{}}

      iex> delete_character(character)
      {:error, %Ecto.Changeset{}}

  """
  def delete_character(%Character{} = character) do
    Repo.delete(character)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking character changes.

  ## Examples

      iex> change_character(character)
      %Ecto.Changeset{source: %Character{}}

  """
  def change_character(%Character{} = character) do
    Character.changeset(character, %{})
  end
end
