use Mix.Config

config :n2o,
  mq: :n2o_syn,
  port: 8888,
  tables: [:cookies, :ws, :tcp, :async],
  protocols: [:nitro_n2o, :n2o_heart],
  routes: Tpage.Routes

config :kvs,
  dba: :kvs_rocks,
  dba_st: :kvs_st,
  schema: [:kvs, :kvs_stream]
