defmodule SportDataServer.DB do
  use GenServer

  def start_link(opts) do
    opts = Keyword.put_new(opts, :name, __MODULE__)
    GenServer.start_link(__MODULE__, %{table_name: opts[:name]}, opts)
  end

  def lookup(league, season, opts \\ []) do
    opts
    |> Keyword.get(:name, __MODULE__)
    |> :ets.lookup({league, season})
    |> Enum.map(&elem(&1, 1))
  end

  def add_record(league, season, record, opts \\ []) do
    opts
    |> Keyword.get(:name, __MODULE__)
    |> GenServer.call({:add, {league, season}, record})
  end

  def init(%{table_name: table_name}) do
    table = :ets.new(table_name, [:duplicate_bag, :named_table, read_concurrency: true])
    {:ok, %{table: table}}
  end

  def handle_call({:add, key, value}, _from, %{table: table} = state) do
    :ets.insert(table, {key, value})
    {:reply, :ok, state}
  end
end
