defmodule SportDataServerWeb.RecordController do
  use SportDataServerWeb, :controller

  def index(conn, %{"league" => league, "season" => season}) do
    records = SportDataServer.list_records_by_league_season_pair({league, season})

    conn
    |> render("index." <> get_format(conn), records: records)
  end
end
