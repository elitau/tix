use Mix.Config

# Configure your database
config :phoenix_example_app, PhoenixExampleApp.Repo,
  username: System.get_env("PG_USER") || System.get_env("USER") || "postgres",
  password: "postgres",
  database: "phoenix_example_app_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phoenix_example_app, PhoenixExampleAppWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
