defmodule Tix.PinnedTest do
  use Agent

  def start_link(_args) do
    Agent.start_link(fn -> nil end, name: __MODULE__)
  end

  def pin({file_path, _line_number} = path) when is_binary(file_path) do
    Agent.update(__MODULE__, fn _state -> path end)
  end

  def unpin do
    Agent.update(__MODULE__, fn _state -> nil end)
  end

  def pinned_test do
    Agent.get(__MODULE__, & &1)
  end
end
