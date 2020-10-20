use Mix.Config

config :n2o,
  pickler: AES.GCM,
  mq: :n2o_syn,
  port: 50111,
  ttl: 60 * 60 * 4,
  nitro_prolongate: false,
  mqtt_services: [:erp, :wms],
  #ws_services: [:chat, :crm],
  tables: [:cookies, :file, :caching, :ws, :mqtt, :tcp, :async, :track],
  upload: "./priv/storage",
  protocols: [:nitro_n2o, :n2o_heart]#,
  #routes: CRM.Routes

config :kvs,
  dba: :kvs_rocks,
  dba_st: :kvs_st,
  schema: [:kvs, :kvs_stream, :bpe_metainfo]

config :form,
  module: :form2
