defmodule Tix.FileWatcher do
  @moduledoc """
  This module is the main process which listens to file changes,
  triggers commands and notifications
  """
  require Logger
  defstruct changed_files: []

  use GenServer

  @doc false
  def start_link([]), do: start_link()

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @doc false
  def init(_) do
    :erlang.send_after(1000, self(), :handle_file_changes)
    {:ok, path} = File.cwd()
    watch_with_file_system(path)
    IO.puts("Tix is watching your files at #{path}")
    TestIex.start_testing()
    {:ok, %__MODULE__{}}
  end

  defp watch_with_file_system(path) do
    {:ok, pid} = FileSystem.start_link(dirs: [path]) |> IO.inspect(label: :watch_with_file_system)
    FileSystem.subscribe(pid)
  end

  @doc """
  Executes on file changes with fs
  """
  def handle_info({:file_event, _watcher_pid, {path, _events}}, state) do
    matched? = path |> to_string |> path_match?(~r{\.(ex|exs|eex)\z}i)

    changed_files =
      if matched? do
        Enum.uniq(state.changed_files ++ [to_string(path)])
      else
        state.changed_files
      end

    {:noreply, %{state | changed_files: changed_files}}
  end

  @doc "Receives list of changed files and executes tests. Resets changed files state"
  def handle_info(:handle_file_changes, state) do
    case state.changed_files do
      [] ->
        :noop

      [file] ->
        file
        |> Tix.Focus.scan_for_focused_test()
        |> Tix.Selector.tests_for_file()
        |> execute_tests()

      many_files ->
        Tix.debug("Many files changed: #{many_files |> inspect()}. Will NOT execute tests")
    end

    :erlang.send_after(500, self(), :handle_file_changes)
    {:noreply, %{state | changed_files: []}}
  end

  @doc false
  def handle_info({:elixir_code_server, _ref, :required}, state) do
    {:noreply, %{state | changed_files: []}}
  end

  @doc false
  def execute_tests(changed_files) do
    try do
      IEx.Helpers.recompile()

      changed_files
      |> Tix.TestRunner.execute_test()
    rescue
      e ->
        e |> Exception.message() |> IO.inspect()
        __STACKTRACE__ |> Exception.format_stacktrace() |> IO.puts()
    end
  end

  defp path_match?(path, pattern = %Regex{}) do
    Regex.match?(pattern, path)
  end
end
