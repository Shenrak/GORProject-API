defmodule GORprojectWeb.Schema do
  use Absinthe.Schema
  import_types(GORprojectWeb.Schema.Types)

  query do
    field :users, list_of(:user) do
      resolve(&GORproject.Auth.UserResolver.all/2)
    end

    field :user, :user do
      arg(:id, non_null(:id))
      resolve(&GORproject.Auth.UserResolver.find/2)
    end

    field :login, type: :session do
      arg(:username, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&GORproject.Auth.UserResolver.login/2)
    end

    field :characters_by_user, list_of(:character) do
      arg(:user_id, non_null(:id))
      resolve(&GORproject.Object.ObjectResolver.all_characters_by_user_id/2)
    end

    field :characters, list_of(:character) do
      resolve(&GORproject.Object.ObjectResolver.all_characters/2)
    end

    mutation do
      field :create_user, type: :user do
        arg(:username, non_null(:string))
        arg(:password, non_null(:string))
        arg(:email, :string)

        resolve(&GORproject.Auth.UserResolver.create/2)
      end
    end
  end
end
