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
end
