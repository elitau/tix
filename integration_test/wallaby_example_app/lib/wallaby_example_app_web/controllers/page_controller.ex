defmodule WallabyExampleAppWeb.PageController do
  use WallabyExampleAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
