defmodule SportDataServerWeb.LeagueSeasonPairView do
  use SportDataServerWeb, :view
  alias SportDataServerWeb.Protobufs

  def render("index." <> _format, %{pairs: pairs}) do
    Protobufs.LeagueSeasonPairCollection.new(
      league_season_pairs: render_many(pairs, __MODULE__, "show.proto")
    )
  end

  def render("show." <> _format, %{league_season_pair: {league, season}}) do
    Protobufs.LeagueSeasonPair.new(%{league: league, season: season})
  end
end
