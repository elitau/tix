defmodule Tix.FocusTest do
  use ExUnit.Case

  setup do
    Tix.PinnedTest.unpin()
    :ok
  end

  test "pins test if file contains hint" do
    test_file_path =
      Path.join(
        File.cwd!(),
        "integration_test/simple_example_app/test/focus_unit_test.exs"
      )

    Tix.Focus.scan_for_focused_test(test_file_path)

    assert Tix.PinnedTest.pinned_test() ==
             {test_file_path, 5}
  end

  test "release pinned of test if previously hold file does not contain hint" do
    Tix.PinnedTest.pin({__ENV__.file, 13})
    Tix.Focus.scan_for_focused_test(__ENV__.file)

    assert Tix.PinnedTest.pinned_test() == nil
  end

  test "only test files will be considered for pinning" do
    file_path =
      Path.join(
        File.cwd!(),
        "test/example_files/file_containing_focus_comment.ex"
      )

    Tix.Focus.scan_for_focused_test(file_path)

    assert Tix.PinnedTest.pinned_test() == nil
  end
end
