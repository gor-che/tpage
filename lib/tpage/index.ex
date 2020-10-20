defmodule Tpage.Index do
  require NITRO
  require FORM

  def event(:init) do
    IO.inspect(["INITED"])
    event(:build_table)
  end

  def event(:build_table) do
    table = "<tr><td>1</td><td>point</td></tr>"
    :nitro.insert_after(:table, table)
  end
end