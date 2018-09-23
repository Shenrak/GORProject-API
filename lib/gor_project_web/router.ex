defmodule GORprojectWeb.Router do
  use GORprojectWeb, :router

  pipeline :auth_api do
    plug(Phoenix.Token.Plug.VerifyHeader, salt: "user salt", max_age: 1_209_600)
    plug(Phoenix.Token.Plug.EnsureAuthenticated, handler: GORproject.AuthController)
  end

  pipeline :api do
    plug(:accepts, ["json"])
    plug(:fetch_session)
  end

  scope "/api", GORprojectWeb do
    pipe_through(:api)
    post("/users", UserController, :create)
    post("/users/sign_in", UserController, :sign_in)
  end

  scope "/api", GORprojectWeb do
    pipe_through([:api, :auth_api])
    resources("/users", UserController, except: [:delete, :create, :new, :edit])

    resources("/characters", CharacterController, except: [:update, :show, :new, :edit])
    get("/characters/one", CharacterController, :show)

    resources("/items", ItemController, except: [:update, :show, :new, :edit])
    get("/items/one", ItemController, :show)

    post("/stats", StatController, :create)
    delete("/stats", StatController, :delete)
  end
end
