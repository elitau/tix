defmodule SimpleExampleAppTest do
  use ExUnit.Case
  doctest SimpleExampleApp

  test "greets the world" do
    assert SimpleExampleApp.hello() == :world
  end
end
