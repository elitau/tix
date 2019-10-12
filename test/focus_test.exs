defmodule Tix.FocusTest do
  use ExUnit.Case

  test "hold test if file contains hint" do
    test_file_path =
      Path.join(
        File.cwd!(),
        "/integration_test/simple_example_app/test/focus_unit_test.exs"
      )

    Tix.Focus.scan_for_focused_test(test_file_path)

    assert Tix.PinnedTest.pinned_test() ==
             {test_file_path, 5}
  end

  test "release hold of test if previously hold file does not contain hint" do
    Tix.PinnedTest.pin({__ENV__.file, 13})
    Tix.Focus.scan_for_focused_test(__ENV__.file)

    assert Tix.PinnedTest.pinned_test() == nil
  end
end
