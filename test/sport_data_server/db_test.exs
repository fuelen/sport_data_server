defmodule SportDataServer.DBTest do
  use ExUnit.Case
  alias SportDataServer.DB

  setup do
    opts = [name: __MODULE__]
    {:ok, pid} = DB.start_link(opts)

    on_exit(fn ->
      Process.exit(pid, :kill)
    end)

    data = [
      {{"league1", "season1"}, :record1},
      {{"league2", "season2"}, :record2},
      {{"league3", "season3"}, :record3_1},
      {{"league3", "season3"}, :record3_2}
    ]

    [data: data, opts: opts, pid: pid]
  end

  test "API", %{data: data, opts: opts} do
    data
    |> Enum.each(fn {{league, season}, record} ->
      assert :ok = DB.insert({league, season}, record, opts)
    end)

    assert DB.lookup({"league1", "season1"}, opts) == [:record1]
    assert DB.lookup({"league2", "season2"}, opts) == [:record2]
    assert DB.lookup({"league3", "season3"}, opts) == [:record3_1, :record3_2]
    assert DB.lookup({"league4", "season4"}, opts) == []

    assert [
             {"league2", "season2"},
             {"league3", "season3"},
             {"league1", "season1"}
           ] = opts |> DB.keys() |> Enum.to_list()
  end
end
