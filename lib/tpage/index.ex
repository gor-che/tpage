defmodule Tpage.Index do
  require NITRO
  require FORM
  require KVS

  def event(:init) do
    :scroll.event(:init)
  end

  def event({:fill_table, _tId, _rid}) do
    :scroll.fill_table()
  end

  def event({:append_rows, tableId, readerId}) do
    IO.inspect("UPPEND EVENT")
    :scroll.add_row('/points',readerId)#show_rows('/points', readerId)
    #:nitro.wire("set_height(qi('table')['data-scroll']);")
  end

  def event({:append_row_before, tId, rId, fId} = mes) do
    :scroll.insert_tr_before(fId,rId)
    # d = :kvs.take(KVS.reader(:kvs.load_reader(rId), args: 1, dir: 1))
    # :kvs.save(KVS.reader(d, dir: 1, pos: 0))
    # KVS.reader(args: rows) = d
    # IO.inspect(d, label: "rows")
    # case rows do
    #   [{:data, fId}] ->
    #     for tr <- rows do
    #       row = NITRO.tr(
    #         id: :nitro.to_atom(elem(tr, 1)),
    #         cells: [
    #           NITRO.td(body: :nitro.to_binary(elem(tr, 1))),
    #           NITRO.td(body: :nitro.to_binary("point"))
    #       ])
    #       :nitro.insert_top(:table, row)
    #     end
    #   [{:data, _}] -> 
    #     IO.inspect([rows,mes], label: "M")
    #     #if fId != 1, do: event(mes)
    #   [] -> :nothing
    # end
  end

  def event({:scroll, _tid, _parH, _tH, _offsetAcc, _offset}=data) do
    :scroll.event(data)
  end

  def event(mess) do
    # :scroll.event(mess)
    IO.inspect(mess, label: "Undef event")
  end

  def show_rows(_feed, _rid) do
    # d = :kvs.take(KVS.reader(:kvs.load_reader(rid), args: 1, dir: 0))
    # :kvs.save(KVS.reader(d, dir: 1))
    # KVS.reader(args: rows, id: rid) = d
    # IO.inspect(rows,label: "##row")
    # for r <- rows do
    #   row = NITRO.tr(
    #     id: :nitro.to_atom(elem(r, 1)),
    #     cells: [
    #       NITRO.td(body: :nitro.to_binary(elem(r,1))),
    #       NITRO.td(body: :nitro.to_binary("point"))
    #     ]
    #   )
    #   IO.inspect("ADD ROW")
    #   :nitro.insert_bottom(:table, row)
    # end
    
  end
end