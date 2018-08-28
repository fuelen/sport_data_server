defmodule SportDataServerWeb.Router do
  use SportDataServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SportDataServerWeb do
    pipe_through :api
  end
end
