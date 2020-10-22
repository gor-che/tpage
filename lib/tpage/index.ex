defmodule Tpage.Index do
  require NITRO
  require FORM
  require KVS

  def event(:init) do
    remote = '/points'
    #:rand.uniform(100000)
    Enum.each(:kvs.all(remote), &:kvs.delete(remote, elem(&1,1)))
    for x <- :lists.seq(1,100), do: :kvs.append({:data, x}, '/points')
    event(:build_table)
  end

  def event(:build_table) do
    KVS.reader(id: rid) = :kvs.save(:kvs.reader('/points'))
    IO.inspect(rid, label: "reader")
    
    show_rows('/points', rid)
    :nitro.wire("qi('table')['data-rid']= #{rid};set_height();")
  end

  def event({:append_rows, tableId, readerId}) do
    IO.inspect("UPPEND EVENT")
    show_rows('/points', readerId)
  end

  def event(mess) do
    IO.inspect(mess, label: "Undef event")
  end

  def show_rows(feed, rid) do
    d = :kvs.take(KVS.reader(:kvs.load_reader(rid), args: 10, dir: 0))
    :kvs.save(d)
    KVS.reader(args: rows, id: rid) = d

    for r <- rows do
      row = NITRO.tr(cells: [
        NITRO.td(body: :nitro.to_binary(elem(r,1))),
        NITRO.td(body: :nitro.to_binary("point")),
      ])
      :nitro.insert_bottom(:table, row)
    end
    
  end
end