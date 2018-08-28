defmodule SportDataServerWeb.LeagueSeasonPairControllerTest do
  use SportDataServerWeb.ConnCase

  describe "index" do
    setup do
      SportDataServer.insert_record("league1", "season1", %{
        away_team: "Osasuna",
        date: ~D[2016-08-19],
        ftag: 1,
        fthg: 1,
        ftr: "D",
        home_team: "Malaga",
        htag: 0,
        hthg: 0,
        htr: "D",
        league: "SP1",
        season: "201617"
      })

      SportDataServer.insert_record("league3", "season2", %{
        away_team: "Betis",
        date: ~D[2016-08-20],
        ftag: 2,
        fthg: 6,
        ftr: "H",
        home_team: "Barcelona",
        htag: 1,
        hthg: 3,
        htr: "H",
        league: "SP1",
        season: "201617"
      })

      SportDataServer.insert_record("league1", "season1", %{
        away_team: "Eibar",
        date: ~D[2016-08-19],
        ftag: 1,
        fthg: 2,
        ftr: "H",
        home_team: "La Coruna",
        htag: 0,
        hthg: 0,
        htr: "D",
        league: "SP1",
        season: "201617"
      })
    end

    test ".json", %{conn: conn} do
      resp = get(conn, league_season_pair_path(conn, :index, "json"))
      assert data = json_response(resp, 200)

      assert data == %{
               "pairs" => [
                 %{"league" => "league3", "season" => "season2"},
                 %{"league" => "league1", "season" => "season1"}
               ]
             }
    end

    test ".proto", %{conn: conn} do
      resp = get(conn, league_season_pair_path(conn, :index, "proto"))
      assert data = resp.resp_body

      assert data |> SportDataServerWeb.Protobufs.PairCollection.decode() ==
               %SportDataServerWeb.Protobufs.PairCollection{
                 pairs: [
                   %SportDataServerWeb.Protobufs.Pair{league: "league3", season: "season2"},
                   %SportDataServerWeb.Protobufs.Pair{league: "league1", season: "season1"}
                 ]
               }
    end
  end
end
