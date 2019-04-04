defmodule GORprojectWeb.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: GORproject.Repo
  import Poison

  object :user do
    field(:id, :id)
    field(:username, :string)
    field(:email, :string)
    field(:password, :string)
    field(:characters, list_of(:character), resolve: assoc(:character))
    # many_to_many(:rooms, Room, join_through: "user_room")
    # field(:posts, list_of(:blog_post), resolve: assoc(:blog_posts))
  end

  object :session do
    field(:token, :string)
  end

  object :character do
    field(:id, :id)
    field(:stats, list_of(:json))
    field(:uuid, :string)
    field(:name, :string)
    field(:user, :user, resolve: assoc(:user))
    field(:items, list_of(:item), resolve: assoc(:item))
  end

  object :item do
    field(:id, :id)
    field(:stats, list_of(:json))
    field(:uuid, :string)
    field(:name, :string)
    field(:character, :character, resolve: assoc(:character))
  end

  scalar :json do
    parse(fn input ->
      case Poison.decode(input.value) do
        {:ok, result} -> {:ok, result}
        _ -> :error
      end
    end)

    serialize(&Poison.encode!/1)
  end
end
