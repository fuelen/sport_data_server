defmodule SportDataServerWeb.Router do
  use SportDataServerWeb, :router
  @dialyzer {:nowarn_function, call: 2}

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SportDataServerWeb do
    pipe_through :api
  end
end
