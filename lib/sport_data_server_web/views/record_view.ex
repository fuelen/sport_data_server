defmodule SportDataServerWeb.RecordView do
  use SportDataServerWeb, :view
  alias SportDataServerWeb.Protobufs

  def render("index." <> _format, %{records: records}) do
    Protobufs.RecordCollection.new(records: render_many(records, __MODULE__, "show.proto"))
  end

  def render("show." <> _format, %{record: %{league: league, season: season, date: date} = record}) do
    record
    |> Map.put(:date, Protobufs.from_date(date))
    |> Map.put(:league_season_pair, Protobufs.LeagueSeasonPair.new(%{league: league, season: season}))
    |> Protobufs.Record.new()
  end
  def render(_, props) do
    props |> IO.inspect
  end
end
