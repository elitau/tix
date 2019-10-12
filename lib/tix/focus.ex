defmodule Tix.Focus do
  require Logger

  def scan_for_focused_test(file_path) do
    scan_for_focused_test(
      file_path,
      Tix.PinnedTest.pinned_test(),
      contains_focus_hint?(file_path)
    )

    file_path
  end

  def scan_for_focused_test(_saved_file_path, nil, false), do: nil

  def scan_for_focused_test(saved_file_path, nil, file_content) do
    saved_file_path |> path_to_focus_on(file_content) |> Tix.PinnedTest.pin()
  end

  def scan_for_focused_test(saved_file_path, {saved_file_path, _line_number}, false) do
    Tix.PinnedTest.unpin()
  end

  def scan_for_focused_test(saved_file_path, {pinned_test, _line_number}, _file_content) do
    Logger.warn(
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
