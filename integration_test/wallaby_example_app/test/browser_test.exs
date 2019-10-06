defmodule WallabyExampleApp.Features.BrowserTest do
  use WallabyExampleApp.FeatureCase, async: true

  test "runing test in a headless browser", %{session: session} do
    session
    |> visit("/")
    |> assert_has(Wallaby.Query.text("A productive web framework"))
  end
end
