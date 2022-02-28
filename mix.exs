defmodule Tio.MixProject do
  use Mix.Project

  def project do
    [
      app: :tio,
      deps: deps(),
      dialyzer: dialyzer(),
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      preferred_cli_env: [credo: :test, dialyzer: :test],
      start_permanent: Mix.env() == :prod,
      version: "1.0.0"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:euclid, "~> 0.2.5"}
    ]
  end

  defp dialyzer do
    [
      plt_add_apps: [:ex_unit, :mix],
      plt_add_deps: :app_tree,
      plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
