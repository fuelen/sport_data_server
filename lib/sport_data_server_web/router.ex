defmodule SportDataServerWeb.Router do
  use SportDataServerWeb, :router
  @dialyzer {:nowarn_function, call: 2}

  pipeline :api do

    plug TrailingFormatPlug   # add this
    plug :accepts, ["json", "proto"]
  end

  scope "/", SportDataServerWeb do
    pipe_through :api

    get "/league_season_pairs.:format", LeagueSeasonPairController, :index
    get "/league_season_pairs/:league/:season/records.:format", RecordController, :index
  end
end
