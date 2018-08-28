defmodule SportDataServerWeb.Protobufs do
  use Protobuf, from: Path.wildcard(Path.expand("protobufs/*.proto", __DIR__))

  def encode_to_iodata!(%{__struct__: protobuf_module} = data) do
    protobuf_module.encode(data)
  end

  def from_date(%Date{year: year, month: month, day: day}) do
    __MODULE__.Date.new(%{year: year, month: month, day: day})
  end
end
