defmodule SportDataServer.DB do
  use GenServer
  @type opt :: {:name, atom()}
  @type opts :: [opt()]

  @spec start_link(opts()) :: GenServer.on_start()
  def start_link(opts) do
    opts = Keyword.put_new(opts, :name, __MODULE__)
    GenServer.start_link(__MODULE__, %{table_name: opts[:name]}, opts)
  end

  @spec flush(opts()) :: :ok
  def flush(opts \\ []) do
    opts
    |> get_table_from_opts()
    |> GenServer.call(:flush)
  end

  @spec lookup(any(), opts()) :: Enumerable.t()
  def lookup(key, opts \\ []) do
    opts
    |> get_table_from_opts()
    |> :ets.lookup(key)
    |> Enum.map(&elem(&1, 1))
  end

  @spec insert(any(), any(), opts()) :: :ok
  def insert(key, record, opts \\ []) do
    opts
    |> get_table_from_opts()
    |> GenServer.call({:insert, key, record})
  end

  @doc """
  Returns a stream with unique keys
  """
  @spec keys(opts()) :: Enumerable.t()
  def keys(opts \\ []) do
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
  def handle_call({:insert, key, value}, _from, %{table: table} = state) do
    :ets.insert(table, {key, value})
    {:reply, :ok, state}
  end

  @impl true
  def handle_call(:flush, _from, %{table: table} = state) do
    :ets.delete_all_objects(table)
    {:reply, :ok, state}
  end

  defp get_table_from_opts(opts) do
    opts
    |> Keyword.get(:name, __MODULE__)
  end
end
