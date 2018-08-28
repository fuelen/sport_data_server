defmodule SportDataServerWeb.LeagueSeasonPairController do
  use SportDataServerWeb, :controller

  def index(conn, _params) do
    pairs = SportDataServer.league_and_season_pairs()
    conn
    |> render("index." <> get_format(conn), pairs: pairs)
  end
end
