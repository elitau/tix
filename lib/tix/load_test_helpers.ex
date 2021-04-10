defmodule Tix.LoadTestHelpers do
  def load_all_test_helpers do
    Task.start(fn ->
      (Mix.Project.config()[:test_paths] ||
         [])
      |> IO.inspect()
      |> Enum.map(&Path.join(&1, "/test_helper.exs"))
      |> Enum.each(&load_helper/1)
    end)
  end

  defp load_helper(path) do
    TestIex.load_helper(path)
    IO.puts("Loaded another test helper: " <> path)
  end
end
