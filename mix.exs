defmodule Tio.MixProject do
  use Mix.Project

  def project do
    [
      app: :tio,
      deps: deps(),
      description: "A few helpful functions for terminal I/O",
      dialyzer: dialyzer(),
      docs: docs(),
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      name: "Tío",
      package: [
        file: ~w[
          .formatter.ex
          CHANGELOG.md
          lib
          LICENSE.md
          mix.exs
          README.md
          VERSION
        ],
        licenses: ["MIT-0"],
        links: %{}
      ],
      preferred_cli_env: [credo: :test, dialyzer: :test],
      source_url: "https://github.com/geometerio/tio",
      start_permanent: Mix.env() == :prod,
      version: version()
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
      {:euclid, "~> 0.2.5"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp dialyzer do
    [
      plt_add_apps: [:ex_unit, :mix],
      plt_add_deps: :app_tree,
      plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
    ]
  end

  defp docs do
    [
      main: "Tío",
      extras: ["README.md"]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp version do
    case File.read("VERSION") do
      {:error, _} -> "0.0.0"
      {:ok, version_number} -> version_number |> String.trim()
    end
  end
end
