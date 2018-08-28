defmodule SportDataServer.DB do
  use GenServer
  @type opt :: {:name, atom()}
  @type opts :: [opt()]

  @spec start_link(opts()) :: GenServer.on_start()
  def start_link(opts) do
    opts = Keyword.put_new(opts, :name, __MODULE__)
    GenServer.start_link(__MODULE__, %{table_name: opts[:name]}, opts)
  end

  @spec lookup(String.t(), String.t(), opts()) :: Enumerable.t()
  def lookup(league, season, opts \\ []) do
    opts
    |> get_table_from_opts()
    |> :ets.lookup({league, season})
    |> Enum.map(&elem(&1, 1))
  end

  @spec add_record(String.t(), String.t(), map(), opts()) :: :ok
  def add_record(league, season, record, opts \\ []) do
    opts
    |> get_table_from_opts()
    |> GenServer.call({:add, {league, season}, record})
  end

  @spec league_and_season_pairs(opts()) :: Enumerable.t()
  def league_and_season_pairs(opts \\ []) do
    eot = :"$end_of_table"
    table = get_table_from_opts(opts)

    Stream.resource(
      fn -> [] end,
      fn acc ->
        case acc do
          [] ->
            case :ets.first(table) do
              ^eot -> {:halt, acc}
              first_key -> {[first_key], first_key}
            end

          acc ->
            case :ets.next(table, acc) do
              ^eot -> {:halt, acc}
              next_key -> {[next_key], next_key}
            end
        end
      end,
      fn _acc -> :ok end
    )
  end

  @impl true
  def init(%{table_name: table_name}) do
    table = :ets.new(table_name, [:duplicate_bag, :named_table, read_concurrency: true])
    {:ok, %{table: table}}
  end

  @impl true
  def handle_call({:add, key, value}, _from, %{table: table} = state) do
    :ets.insert(table, {key, value})
    {:reply, :ok, state}
  end

  defp get_table_from_opts(opts) do
    opts
    |> Keyword.get(:name, __MODULE__)
  end
end
