defmodule GORproject.Object do
  @moduledoc """
  The Object context.
  """

  import Ecto.Query, only: [from: 2]
  alias GORproject.Repo

  alias GORproject.Object.Character
  alias GORproject.Object.Item

  def add_stat(uuid, newStat) do
    queryC =
      from(
        c in Character,
        where: c.uuid == ^uuid,
        select: c
      )

    queryI =
      from(
        i in Item,
        where: i.uuid == ^uuid,
        select: i
      )

    case Repo.one(queryC) do
      nil ->
        case Repo.one(queryI) do
          nil ->
            {:error, "No object found for the given uuid"}

          item ->
            stats = Map.put(item.stats, newStat["name"], newStat["value"])

            Item.changeset(item, %{stats: stats})
            |> Repo.update()
        end

      character ->
        stats = Map.put(character.stats, newStat["name"], newStat["value"])

        Character.changeset(character, %{stats: stats})
        |> Repo.update()
    end
  end

  def delete_stat(uuid, stat) do
    queryC =
      from(
        c in Character,
        where: c.uuid == ^uuid,
        select: c
      )

    queryI =
      from(
        i in Item,
        where: i.uuid == ^uuid,
        select: i
      )

    case Repo.one(queryC) do
      nil ->
        case Repo.one(queryI) do
          nil ->
            {:error, "No object found for the given uuid"}

          item ->
            stats = Map.delete(item.stats, stat)

            Item.changeset(item, %{stats: stats})
            |> Repo.update()
        end

      character ->
        stats = Map.delete(character.stats, stat)

        Character.changeset(character, %{stats: stats})
        |> Repo.update()
    end
  end

  @doc """
  Returns the list of characters.

  ## Examples

      iex> list_characters()
      [%Character{}, ...]

  """
  def list_characters do
    # Repo.all(Character)
    Repo.all(from(c in Character, preload: :items))
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
  def get_character(uuid) do
    case Repo.all(from(c in Character, where: c.uuid == ^uuid, preload: :items)) do
      [] ->
        {:error, :bad_request}

      list ->
        {:ok, hd(list)}
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
    %Character{items: []}
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

      iex> delete_character(id, uuid)
      {:ok, %Character{}}

      iex> delete_character(id, uuid)
      {:error, %Ecto.Changeset{}}

  """
  def delete_character(id, uuid) do
    Repo.all(from(c in Character, where: c.id == ^id, where: c.uuid == ^uuid))
    |> hd()
    |> Repo.delete()
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

  alias GORproject.Object.Item

  @doc """
  Returns the list of item.

  ## Examples

      iex> list_item()
      [%Item{}, ...]

  """
  def list_item do
    Repo.all(Item)
  end

  @doc """
  Gets a single item.

  Raises `Ecto.NoResultsError` if the Item does not exist.

  ## Examples

      iex> get_item!(123)
      %Item{}

      iex> get_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_item(uuid) do
    case Repo.all(from(i in Item, where: i.uuid == ^uuid)) do
      [] ->
        {:error, :bad_request}

      list ->
        {:ok, hd(list)}
    end
  end

  @doc """
  Creates a item.

  ## Examples

      iex> create_item(%{field: value})
      {:ok, %Item{}}

      iex> create_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_item(attrs \\ %{}) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a item.

  ## Examples

      iex> update_item(item, %{field: new_value})
      {:ok, %Item{}}

      iex> update_item(item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_item(%Item{} = item, attrs) do
    item
    |> Item.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Item.

  ## Examples

      iex> delete_item(id, uuid)
      {:ok, %Item{}}

      iex> delete_item(id, uuid)
      {:error, %Ecto.Changeset{}}

  """
  def delete_item(id, uuid) do
    Repo.all(from(i in Item, where: i.id == ^id, where: i.uuid == ^uuid))
    |> hd()
    |> Repo.delete()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking item changes.

  ## Examples

      iex> change_item(item)
      %Ecto.Changeset{source: %Item{}}

  """
  def change_item(%Item{} = item) do
    Item.changeset(item, %{})
  end
end
