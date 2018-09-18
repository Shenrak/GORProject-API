defmodule GORprojectWeb.Router do
  use GORprojectWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
    plug(:fetch_session)
  end

  scope "/api", GORprojectWeb do
    pipe_through(:api)
    resources("/characters", CharacterController, except: [:new, :edit])
    resources("/stats", StatController, only: [:create]) # :delete :show
  end
end
