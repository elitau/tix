defmodule TixTest do
  use ExUnit.Case
  doctest Tix

  test "greets the world" do
    assert Tix.hello() == :world
  end
end
