defmodule Tpage.MixProject do
  use Mix.Project

  def project do
    [
      app: :tpage,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Tpage.Application, []}
    ]
  end

  defp deps do
    [
      {:cowboy, "~> 2.7.0"},
      {:rocksdb, "~> 1.3.2"},
      {:n2o, "~> 7.8.3"},
      {:kvs, "~> 7.9.1", override: true},
      {:nitro, "~> 5.9.2", override: true},
      {:form, "~> 5.8.7"}
    ]
  end
end
