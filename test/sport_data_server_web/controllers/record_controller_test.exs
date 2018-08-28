defmodule SportDataServerWeb.RecordControllerTest do
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

      SportDataServer.insert_record("league1", "season2", %{
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
      resp = get(conn, record_path(conn, :index, "league1", "season1", "json"))
      assert data = json_response(resp, 200)

      assert data ==
               %{
                 "records" => [
                   %{
                     "away_team" => "Osasuna",
                     "date" => %{"day" => 19, "month" => 8, "year" => 2016},
                     "ftag" => 1,
                     "fthg" => 1,
                     "ftr" => "D",
                     "home_team" => "Malaga",
                     "htag" => 0,
                     "hthg" => 0,
                     "htr" => "D",
                     "league" => "SP1",
                     "season" => "201617"
                   },
                   %{
                     "away_team" => "Eibar",
                     "date" => %{"day" => 19, "month" => 8, "year" => 2016},
                     "ftag" => 1,
                     "fthg" => 2,
                     "ftr" => "H",
                     "home_team" => "La Coruna",
                     "htag" => 0,
                     "hthg" => 0,
                     "htr" => "D",
                     "league" => "SP1",
                     "season" => "201617"
                   }
                 ]
               }
    end

    test ".proto", %{conn: conn} do
      resp = get(conn, record_path(conn, :index, "league1", "season1", "proto"))
      assert data = resp.resp_body

      assert data |> SportDataServerWeb.Protobufs.RecordCollection.decode() ==
               %SportDataServerWeb.Protobufs.RecordCollection{
                 records: [
                   %SportDataServerWeb.Protobufs.Record{
                     away_team: "Osasuna",
                     date: %SportDataServerWeb.Protobufs.Date{
                       day: 19,
                       month: 8,
                       year: 2016
                     },
                     ftag: 1,
                     fthg: 1,
                     ftr: "D",
                     home_team: "Malaga",
                     htag: 0,
                     hthg: 0,
                     htr: "D",
                     league: "SP1",
                     season: "201617"
                   },
                   %SportDataServerWeb.Protobufs.Record{
                     away_team: "Eibar",
                     date: %SportDataServerWeb.Protobufs.Date{
                       day: 19,
                       month: 8,
                       year: 2016
                     },
                     ftag: 1,
                     fthg: 2,
                     ftr: "H",
                     home_team: "La Coruna",
                     htag: 0,
                     hthg: 0,
                     htr: "D",
                     league: "SP1",
                     season: "201617"
                   }
                 ]
               }
    end
  end
end
