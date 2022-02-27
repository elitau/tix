defmodule WallabyExampleApp.Features.BrowserTest do
  use WallabyExampleApp.FeatureCase, async: true

  test "runing test in a headless browser", %{session: session} do
    Application.put_env(:wallaby, :base_url, WallabyExampleAppWeb.Endpoint.url())
    session
    |> visit("/")
    |> assert_has(Wallaby.Query.text("A productive web framework"))
  end
end
