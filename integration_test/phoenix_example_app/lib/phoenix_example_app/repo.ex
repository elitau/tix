defmodule PhoenixExampleApp.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_example_app,
    adapter: Ecto.Adapters.Postgres
end
