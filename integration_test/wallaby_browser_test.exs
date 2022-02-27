defmodule WallabyExampleApp.Features.BrowserTest do
  use Wallaby.Feature, async: true

  test "runing test in a headless browser", %{session: session} do
    Application.put_env(:wallaby, :base_url, WallabyExampleAppWeb.Endpoint.url())

    session
    |> visit("/")
    |> assert_has(Wallaby.Query.text("Welcome to Phoenix"))
  end
end
