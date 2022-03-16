defmodule Tix.FileWatcher do
  @moduledoc """
  This module is the main process which listens to file changes,
  triggers commands and notifications
  """
  require Logger
  defstruct runner: :not_set
  @default_test_runner &Tix.TestRunner.execute_test/1

  use GenServer

  @doc false
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @doc false
  def init(opts \\ []) do
    {:ok, path} = File.cwd()
    watch_with_file_system(path)
    IO.puts("Tix is watching your files at #{path}")
    TestIex.start_testing()
    {:ok, %__MODULE__{runner: Keyword.get(opts, :runner, @default_test_runner)}}
  end

  defp watch_with_file_system(path) do
    {:ok, pid} = FileSystem.start_link(dirs: [path]) |> IO.inspect(label: :watch_with_file_system)
    FileSystem.subscribe(pid)
  end

  @doc """
  Executes on file changes with fs
  """
  def handle_info({:file_event, _watcher_pid, {path, _events}}, state) do
    if valid_file?(path) do
      path |> to_string() |> handle_file_change(state)
    end

    {:noreply, state}
  end

  @doc false
  def handle_info({:elixir_code_server, _ref, :required}, state) do
    {:noreply, %{state | changed_files: []}}
  end

  defp handle_file_change(file, state) do
    file
    |> Tix.Focus.scan_for_focused_test()
    |> Tix.Selector.tests_for_file()
    |> execute_tests(state)
  end

  @doc false
  def execute_tests(files_to_execute, %{runner: runner}) do
    try do
      IEx.Helpers.recompile()

      runner.(files_to_execute)
    rescue
      e ->
        e |> Exception.message() |> IO.inspect()
        __STACKTRACE__ |> Exception.format_stacktrace() |> IO.puts()
    end
  end

  defp valid_file?(path) do
    path |> to_string |> path_match?(~r{\.(ex|exs|eex)\z}i)
  end

  defp path_match?(path, pattern = %Regex{}) do
    Regex.match?(pattern, path)
  end
end
