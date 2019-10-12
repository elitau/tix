defmodule Tix.Focus do
  def scan_for_focused_test(file_path) do
    scan_for_focused_test(
      file_path,
      Tix.PinnedTest.pinned_test(),
      contains_focus_hint?(file_path),
      file_path |> String.ends_with?("_test.exs")
    )

    file_path
  end

  def scan_for_focused_test(_saved_file_path, nil, false, _is_test_file?),
    do: :nothing_pinned_and_no_comment

  def scan_for_focused_test(_saved_file_path, nil, _file_content, false), do: :not_a_test_file

  def scan_for_focused_test(saved_file_path, nil, file_content, true) do
    saved_file_path |> path_to_focus_on(file_content) |> Tix.PinnedTest.pin()
    Tix.debug("Focus: Pinned #{saved_file_path}")
  end

  def scan_for_focused_test(
        saved_file_path,
        {saved_file_path, _line_number},
        false,
        _is_test_file?
      ) do
    Tix.PinnedTest.unpin()
    Tix.debug("Unpinned #{saved_file_path}")
  end

  def scan_for_focused_test(
        saved_file_path,
        {saved_file_path, _line_number},
        _file_content,
        _is_test_file?
      ) do
    Tix.debug("Keep #{saved_file_path} pinned")
    :test_already_pinned
  end

  def scan_for_focused_test(
        saved_file_path,
        {pinned_test, _line_number},
        _file_content,
        _is_test_file?
      ) do
    Tix.debug(
      "Found focus in file #{saved_file_path}, but Tix is already focused on #{pinned_test}. Tix did not change the pinned test."
    )
  end

  defp contains_focus_hint?(file_path) do
    case File.read(file_path) do
      {:ok, content} ->
        String.match?(content, ~r/#.*tix.*focus/) && content

      {:error, _posix_error} ->
        false
    end
  end

  defp path_to_focus_on(path, content) do
    line_number =
      String.split(content, "\n")
      |> Enum.find_index(&String.match?(&1, ~r/^.*#.*tix.*focus.*$/))

    case line_number do
      nil ->
        nil

      line_number ->
        # add 1 because the index is zero based
        # add another 1 because the test is one line below the comment
        {path, line_number + 2}
    end
  end
end
