defmodule SportDataServer do
  @moduledoc """
  SportDataServer is a facade for business logic
  """
  alias SportDataServer.DB

  @spec insert_record(String.t(), String.t(), map(), DB.opts()) :: :ok
  def insert_record(league, season, record, opts \\ []) do
    DB.insert({league, season}, record, opts)
  end

  @spec list_records_by_league_season_pair({String.t(), String.t()}, DB.opts()) :: Enumerable.t()
  def list_records_by_league_season_pair({_league, _season} = pair, opts \\ []) do
    DB.lookup(pair, opts)
  end

  @spec league_and_season_pairs(DB.opts()) :: Enumerable.t()
  def league_and_season_pairs(opts \\ []) do
    DB.keys(opts)
  end
end
