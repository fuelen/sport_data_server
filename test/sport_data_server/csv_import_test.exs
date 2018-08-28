defmodule SportDataServer.CSVImportTest do
  use ExUnit.Case
  alias SportDataServer.CSVImport
  import ExUnit.CaptureLog

  @csv """
  "","Div","Season","Date","HomeTeam","AwayTeam","FTHG","FTAG","FTR","HTHG","HTAG","HTR"
  "1","SP1","201617","19/08/16","La Coruna","Eibar",2,1,"H",0,0,"D"
  "2","SP1","201617","19/08/16","Malaga","Osasuna",1,1,"D",0,0,"D"
  "3","SP1","201617","20/08/16","Barcelona","Betis",6,2,"H",3,1,"H"
  "4",
  """
  test "import_stream/2" do
    pid = self()

    assert capture_log(fn ->
             @csv
             |> String.split("\n")
             |> CSVImport.import_stream(fn record ->
               send(pid, record)
             end)
           end) =~ ~r/invalid_format.+invalid_format/s

    assert_received %{
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
    }

    assert_received %{
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
    }

    assert_received %{
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
    }
  end
end
