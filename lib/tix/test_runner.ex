defmodule Tix.TestRunner do
  def execute_test({path, line_number}) do
    before_run(path)
    TestIex.test(path, line_number)
  end

  def before_run(paths) do
    IEx.Helpers.clear()
    output_files_executed(paths)
  end

  def output_files_executed(paths) when is_list(paths) do
    paths |> Enum.each(&IO.puts("Executing #{&1 |> inspect}"))
  end

  def output_files_executed(path) do
    IO.puts("Executing #{path |> inspect}")
  end
end
