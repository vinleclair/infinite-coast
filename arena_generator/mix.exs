defmodule ArenaGenerator.MixProject do
  use Mix.Project

  def project do
    [
      app: :garena,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript(),

      # Docs
      name: "Arenas & Angels",
      source_url: "https://github.com/BinaryTiger/a-a"
    ]
  end

  def application do
    [
      extra_applications: [:logger, :yamerl]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:yaml_elixir, "~> 2.4.0"}
    ]
  end

  defp escript do
    [main_module: ArenaGenerator.CLI]
  end
end
