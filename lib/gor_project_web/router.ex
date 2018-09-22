defmodule GORprojectWeb.Router do
  use GORprojectWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
    plug(:fetch_session)
  end

  scope "/api", GORprojectWeb do
    pipe_through(:api)
    resources("/users", UserController, except: [:new, :edit])

    resources("/characters", CharacterController, except: [:update, :show, :new, :edit])
    get("/characters/one", CharacterController, :show)

    resources("/items", ItemController, except: [:update, :show, :new, :edit])
    get("/items/one", ItemController, :show)

    post("/stats", StatController, :create)
    delete("/stats/:stat", StatController, :delete)
  end
end
