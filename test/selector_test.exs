defmodule Tix.SelectorTest do
  use ExUnit.Case, async: true

  # tix:focus
  test "file contains a '# tix:focus' comment" do
    assert [{"test/selector_test.exs", 5}, _] =
             Tix.Selector.tests_for_file(["test/selector_test.exs"])
  end
end
