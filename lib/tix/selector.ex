defmodule Tix.Selector do
  def tests_for_file([file_path]), do: tests_for_file(file_path)

  def tests_for_file(file_path) do
    file_path
    |> possible_test_file_paths()
    |> Enum.filter(&is_test_file?/1)
    |> Enum.filter(&file_exists?/1)
    |> Enum.uniq()
    |> List.first()
  end

  def is_test_file?(path) when is_binary(path) do
    String.contains?(path, "_test.exs")
  end

  def is_test_file?({path, _line_number}) when is_binary(path) do
    String.contains?(path, "_test.exs")
  end

  def file_exists?(path) when is_binary(path) do
    File.exists?(path)
  end

  def file_exists?({path, _line_number}) when is_binary(path) do
    File.exists?(path)
  end

  def possible_test_file_paths(nil), do: []
  def possible_test_file_paths(""), do: []
  def possible_test_file_paths([]), do: []

  def possible_test_file_paths(path) when is_binary(path) do
    [
      Tix.PinnedTest.pinned_test(),
      {path, nil},
      {nearby_path(path), nil},
      {test_folder_path(path), nil}
    ]
    |> Enum.reject(fn path -> is_nil(path) end)
  end

  def nearby_path(path) do
    path |> to_test_file_naming()
  end

  def test_folder_path(path) do
    path |> String.replace("/lib/", "/test/") |> to_test_file_naming()
  end

  defp to_test_file_naming(path) do
    path |> String.replace_trailing(".ex", "_test.exs")
  end
end
