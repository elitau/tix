use Mix.Config

# Configure your database
config :example_app, ExampleApp.Repo,
  username: System.get_env("PG_USER") || System.get_env("USER") || "postgres",
  password: "postgres",
  database: "example_app_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :example_app, ExampleAppWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
