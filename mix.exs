defmodule Tix.MixProject do
  use Mix.Project

  def project do
    [
      app: :tix,
      version: "0.4.2",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
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
      {:test_iex, "~> 0.1.1"},
      {:ex_doc, "~> 0.20", only: :dev, runtime: false},
      {:file_system, "~> 0.2"}
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

  defp aliases do
    [
      "test.integration": &lux_integration_test/1
    ]
  end

  defp lux_integration_test(_) do
    Mix.shell().cmd(
      ~S(lux -v integration_test/simple_example_app/integration_test.lux integration_test/simple_example_app/focus_test.lux integration_test/simple_example_app/load_all_test_helpers_test.lux integration_test/phoenix_example_app/integration_test.lux integration_test/wallaby_example_app/integration_test.lux)
    )
  end
end
