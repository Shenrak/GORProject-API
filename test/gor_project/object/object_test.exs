defmodule GORproject.ObjectTest do
  use GORproject.DataCase

  alias GORproject.Object

  describe "characters" do
    alias GORproject.Object.Character

    @valid_attrs %{stats: "{}", name: "some name"}
    @update_attrs %{stats: "{\"strength\"}", name: "some updated name"}
    @invalid_attrs %{stats: nil, name: nil}

    def character_fixture(attrs \\ %{}) do
      {:ok, character} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Object.create_character()

      character
    end

    test "list_characters/0 returns all characters" do
      character = character_fixture()
      assert Object.list_characters() == [character]
    end

    test "get_character!/1 returns the character with given id" do
      character = character_fixture()
      assert Object.get_character!(character.id) == character
    end

    test "create_character/1 with valid data creates a character" do
      assert {:ok, %Character{} = character} = Object.create_character(@valid_attrs)
      assert character.stats == "{}"
      assert {:ok, something} = Ecto.UUID.dump(character.uuid)
      assert character.name == "some name"
    end

    test "create_character/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Object.create_character(@invalid_attrs)
    end

    test "update_character/2 with valid data updates the character" do
      character = character_fixture()
      assert {:ok, character} = Object.update_character(character, @update_attrs)
      assert %Character{} = character
      assert character.stats == "{\"strength\"}"
      assert {:ok, something} = Ecto.UUID.dump(character.uuid)
      assert character.name == "some updated name"
    end

    test "update_character/2 with invalid data returns error changeset" do
      character = character_fixture()
      assert {:error, %Ecto.Changeset{}} = Object.update_character(character, @invalid_attrs)
      assert character == Object.get_character!(character.id)
    end

    test "delete_character/1 deletes the character" do
      character = character_fixture()
      assert {:ok, %Character{}} = Object.delete_character(character)
      assert_raise Ecto.NoResultsError, fn -> Object.get_character!(character.id) end
    end

    test "change_character/1 returns a character changeset" do
      character = character_fixture()
      assert %Ecto.Changeset{} = Object.change_character(character)
    end
  end

  describe "item" do
    alias GORproject.Object.Item

    @valid_attrs %{hash: "7488a646-e31f-11e4-aace-600308960662", name: "some name", stats: "some stats"}
    @update_attrs %{hash: "7488a646-e31f-11e4-aace-600308960668", name: "some updated name", stats: "some updated stats"}
    @invalid_attrs %{hash: nil, name: nil, stats: nil}

    def item_fixture(attrs \\ %{}) do
      {:ok, item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Object.create_item()

      item
    end

    test "list_item/0 returns all item" do
      item = item_fixture()
      assert Object.list_item() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Object.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      assert {:ok, %Item{} = item} = Object.create_item(@valid_attrs)
      assert item.hash == "7488a646-e31f-11e4-aace-600308960662"
      assert item.name == "some name"
      assert item.stats == "some stats"
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Object.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      assert {:ok, item} = Object.update_item(item, @update_attrs)
      assert %Item{} = item
      assert item.hash == "7488a646-e31f-11e4-aace-600308960668"
      assert item.name == "some updated name"
      assert item.stats == "some updated stats"
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Object.update_item(item, @invalid_attrs)
      assert item == Object.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Object.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Object.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Object.change_item(item)
    end
  end
end
