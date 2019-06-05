defmodule Tix do
  @moduledoc """
  Documentation for Tix.
  """

  def start do
    Code.compiler_options(ignore_module_conflict: true)
    Tix.Supervisor.start_link()
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
