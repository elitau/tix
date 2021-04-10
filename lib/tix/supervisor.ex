defmodule Tix.Supervisor do
  use Supervisor

  def start_link(opts \\ []) do
    Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(_opts) do
    children = [Tix.FileWatcher, Tix.PinnedTest]
    Tix.LoadTestHelpers.load_all_test_helpers()
    Supervisor.init(children, strategy: :one_for_one)
  end
end
