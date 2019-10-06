defmodule Tix.MixProject do
  use Mix.Project

  def project do
    [
      app: :tix,
      version: "0.3.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "tix",
      description: "Automatically run tests in the iex console when files are saved",
      package: package(),
      source_url: "https://github.com/elitau/tix",
      homepage_url: "https://github.com/elitau/tix",
      # The main page in the docs
      docs: [main: "readme", extras: ["README.md"]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Tix.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # This module lets execute specific tests from within a running iex shell
      # to avoid needing to start and stop the whole application every time.
      {:test_iex, "~> 0.1.0"},
      {:ex_doc, "~> 0.20", only: :dev, runtime: false},
      # Erlang File System Listener
      {:fs, "~> 0.9"}
    ]
  end

  def package do
    [
      maintainers: ["Eduard Litau"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/elitau/tix"},
      files: ~w(LICENCE README.md lib mix.exs)
    ]
  end
end
