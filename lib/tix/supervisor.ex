defmodule Tix.Supervisor do
  use Supervisor

  def start_link(opts \\ []) do
    Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(_opts) do
    children = [Tix.FileWatcher, Tix.PinnedTest]
    load_all_test_helpers()
    Supervisor.init(children, strategy: :one_for_one)
  end

  defp load_all_test_helpers do
    Task.start(fn ->
      (Mix.Project.config()[:test_paths] ||
         [])
      |> Enum.map(&Path.join(&1, "/test_helper.exs"))
      |> Enum.each(&load_helper/1)
    end)
  end

  defp load_helper(path) do
    TestIex.load_helper(path)
    IO.puts("Loaded another test helper: " <> path)
  end
end
