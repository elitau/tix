defmodule Mix.Tasks.Tix do
  use Mix.Task

  @moduledoc """
  Tix is a TDD tool that runs tests in
  an iex shell upon save of a file.

  This tool should be run in the root of the project directory
  with the following command:
      iex -S mix tix
  """

  def run(_argv) do
    Mix.Task.run("app.start", [])
    # Tix.start()
    Application.ensure_all_started(:tix, :permanent)
  end
end
