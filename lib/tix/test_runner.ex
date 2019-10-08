defmodule Tix.TestRunner do
  def execute_test({path, line_number}) do
    before_run({path, line_number})
    TestIex.test(path, line_number)
  end

  def before_run(path) do
    IEx.Helpers.clear()
    output_files_executed(path)
  end

  def output_files_executed({paths, _line_number}) when is_list(paths) do
    paths |> Enum.each(&IO.puts("Executing #{&1 |> inspect}"))
  end

  def output_files_executed({path, nil}) do
    IO.puts("Executing #{path |> path_to_string()}")
  end

  def output_files_executed({path, line_number}) do
    IO.puts("Executing #{path |> path_to_string()}:" <> to_string(line_number))
  end

  defp path_to_string(path) do
    path |> show_only_directory_structure_from_project
  end

  defp show_only_directory_structure_from_project(path) do
    project_dir = Mix.Project.deps_path() |> String.replace_trailing("deps", "")

    String.replace_leading(path, project_dir, "")
  end
end
