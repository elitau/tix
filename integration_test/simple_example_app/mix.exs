defmodule SimpleExampleApp.MixProject do
  use Mix.Project

  def project do
    [
      app: :simple_example_app,
      version: "0.1.0",
      elixir: "~> 1.9",
      test_paths: ["test", "another_test_folder"],
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {SimpleExampleApp.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tix, path: "../../", runtime: false, only: :test}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
