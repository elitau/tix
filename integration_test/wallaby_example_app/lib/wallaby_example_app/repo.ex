defmodule WallabyExampleApp.Repo do
  use Ecto.Repo,
    otp_app: :wallaby_example_app,
    adapter: Ecto.Adapters.Postgres
end
