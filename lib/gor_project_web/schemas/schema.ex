defmodule GORproject.Web.Schema do
  use Absinthe.Schema
  import_types(GORproject.Web.Schema.Types)

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
