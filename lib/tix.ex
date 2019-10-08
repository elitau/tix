defmodule Tix do
  @moduledoc """
  Documentation for Tix.
  """

  @doc """
  Starts the Tix supervisor that watches the file system and runs the appropriate test(s).
  """
  def start do
    Code.compiler_options(ignore_module_conflict: true)
    {:ok, _started_apps} = Application.ensure_all_started(:fs, :permanent)
    Tix.Supervisor.start_link()
  end

  def running? do
    Process.whereis(Tix.Supervisor)
  end

  def run do
    # changed_file |> select_tests() |> execute_tests()
    # manually_chosen_test |> execute_tests()
  end

  @doc """
  Pin a test so that only this test will be executed on save.
  """
  def pin(path) do
    Tix.PinnedTest.pin(path)
  end

  @doc """
  Unpin any previously pinned test.
  """
  def unpin do
    Tix.PinnedTest.unpin()
  end
end
