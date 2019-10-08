defmodule SimpleExampleFoCusUnitTest do
  use ExUnit.Case

  # tix:focus
  test "always green" do
    assert true
  end

  test "always red" do
    assert "red" == :blue
  end
end
