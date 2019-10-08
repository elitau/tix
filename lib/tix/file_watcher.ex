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
    :ok = :fs.subscribe()
    IO.puts("Tix is watching your files at #{:fs.path()}")
    TestIex.start_testing()
    {:ok, %__MODULE__{}}
  end

  @doc """
  Executes on file changes
  """
  def handle_info({_pid, {:fs, :file_event}, {path, _event}}, state) do
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

      changed_files ->
        changed_files
        |> List.flatten()
        |> Enum.uniq()
        |> execute_tests()
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
      |> debug()
      |> Tix.Selector.tests_for_file()
      |> debug()
      |> Enum.at(0)
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

  defp debug(content) do
    :ok = content |> inspect() |> Logger.debug()
    content
  end
end
