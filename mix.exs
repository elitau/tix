defmodule Tix.MixProject do
  use Mix.Project

  def project do
    [
      app: :tix,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
      # mod: {Tix.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:test_iex, "~> 0.1.0"},
      # Erlang File System Listener
      {:fs, "~> 0.9"}
    ]
  end
end
