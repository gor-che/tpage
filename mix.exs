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

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Tpage.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, "~> 2.7.0"},
      {:rocksdb, "~> 1.3.2"},
      {:amnesia, "~> 0.2.8"},
      {:n2o, "~> 7.8.3"},
      {:kvs, "~> 7.9.1", override: true},
      {:nitro, "~> 5.9.2", override: true},
      {:form, "~> 5.8.7"},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
