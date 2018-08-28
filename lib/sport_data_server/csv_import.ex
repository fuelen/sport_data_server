defmodule SportDataServer.CSVImport do
  @moduledoc """
  This module is responsible for importing CSV data to DB.
  """
  require Logger
  alias SportDataServer.DB
  alias NimbleCSV.RFC4180, as: CSV

  @doc """
  Parses a stream of csv-strings and imports them to the database
  """
  @spec import_stream(stream :: Enumerable.t(), (map() -> any())) :: :ok
  def import_stream(stream, recorder \\ &persist_row/1) do
    stream
    |> CSV.parse_stream()
    |> Stream.each(fn row ->
      row
      |> normalize_row()
      |> case do
        {:ok, normalized_record} ->
          recorder.(normalized_record)

        {:error, reason} ->
          Logger.error("Couldn't normalize row #{inspect(row)} - #{reason}")
      end
    end)
    |> Stream.run()
  end

  defp persist_row(%{league: league, season: season} = record) do
    DB.add_record(league, season, record)
  end

  @doc """
  Formats row from CSV as a map with types conversion
  """
  @spec normalize_row(row :: [String.t()]) ::
          {:ok,
           %{
             league: String.t(),
             season: String.t(),
             date: Date.t(),
             home_team: String.t(),
             away_team: String.t(),
             fthg: non_neg_integer(),
             ftag: non_neg_integer(),
             ftr: String.t(),
             hthg: non_neg_integer(),
             htag: non_neg_integer(),
             htr: String.t()
           }}
          | {:error, :invalid_format}
  def normalize_row([
        _number,
        league,
        season,
        date,
        home_team,
        away_team,
        fthg,
        ftag,
        ftr,
        hthg,
        htag,
        htr
      ]) do
    case Timex.parse(date, "{0D}/{0M}/{YY}") do
      {:ok, datetime} ->
        {:ok,
         %{
           league: league,
           season: season,
           date: datetime |> NaiveDateTime.to_date(),
           home_team: home_team,
           away_team: away_team,
           fthg: String.to_integer(fthg),
           ftag: String.to_integer(ftag),
           ftr: ftr,
           hthg: String.to_integer(hthg),
           htag: String.to_integer(htag),
           htr: htr
         }}

      {:error, _message} ->
        {:error, :invalid_format}
    end
  end

  def normalize_row(_) do
    {:error, :invalid_format}
  end
end
