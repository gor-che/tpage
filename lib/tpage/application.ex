defmodule Tpage.Application do

  use Application

  def start(_type, _args) do
    :n2o.start_ws()
    dispatch = :cowboy_router.compile([
      { :_, [
          {'/app/[...]', :cowboy_static, {:dir, "priv/static", []}},
          {'/ws/[...]', :n2o_cowboy2, []}
        ]}])

    :cowboy.start_clear(:http, env(:tpage), %{env: %{dispatch: dispatch}})
    
  end

  def env(_app) do
    [
      {:port, :application.get_env(:n2o, :port, 50111)}
    ]
  end
end
