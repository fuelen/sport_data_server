defmodule SportDataServerWeb.RecordView do
  use SportDataServerWeb, :view
  alias SportDataServerWeb.Protobufs

  def render("index." <> _format, %{records: records}) do
    Protobufs.RecordCollection.new(records: render_many(records, __MODULE__, "show.proto"))
  end

  def render("show." <> _format, %{record: record}) do
    Protobufs.Record.new(%{
      record
      | date: Protobufs.from_date(record.date)
    })
  end
end
