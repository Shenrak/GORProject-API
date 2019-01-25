defmodule GORproject.Web.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: GORproject.Repo
  import Poison

  object :user do
    field(:id, :id)
    field(:login, :string)
    field(:email, :string)
    field(:password, :string)
    field(:characters, list_of(:character), resolve: assoc(:character))
    # many_to_many(:rooms, Room, join_through: "user_room")
    # field(:posts, list_of(:blog_post), resolve: assoc(:blog_posts))
  end

  object :character do
    field(:id, :id)
    field(:stats, list_of(:json))
    field(:uuid, :string)
    field(:name, :string)
    field(:user, :user, resolve: assoc(:user))
    # has_many(:items, Item)
  end

  scalar :json, description: "JSON field type in postgres" do
    parse fn input ->
      case Poison.decode(input.value) do
        {:ok, result} -> {:ok, result}
        _ -> :error
      end
    end

    serialize &Poison.encode!/1
  end

end
