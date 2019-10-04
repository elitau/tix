defmodule Tix.FocusTest do
  @doc """
  Defines a test with a string.
  Provides a convenient macro that allows a test to be
  defined with a string. This macro automatically inserts
  the atom `:ok` as the last line of the test. That said,
  a passing test always returns `:ok`, but, more importantly,
  it forces Elixir to not tail call optimize the test and
  therefore avoids hiding lines from the backtrace.
  ## Examples
      test "true is equal to true" do
        assert true == true
      end
  """
  defmacro focus(message, var \\ quote(do: _), contents) do
    contents =
      case contents do
        [do: block] ->
          quote do
            unquote(block)
            :ok
          end

        _ ->
          quote do
            try(unquote(contents))
            :ok
          end
      end

    var = Macro.escape(var)
    contents = Macro.escape(contents, unquote: true)

    quote bind_quoted: [var: var, contents: contents, message: message] do
      name = ExUnit.Case.register_test(__ENV__, :test, message, [])
      def unquote(name)(unquote(var)), do: unquote(contents)
    end
  end
end
