use Mix.Config

# Configure your database
config :wallaby_example_app, WallabyExampleApp.Repo,
  username: System.get_env("POSTGRES_USER") || System.get_env("USER") || "postgres",
  password: System.get_env("POSTGRES_PASSWORD") || "postgres",
  database: System.get_env("POSTGRES_DB") || "postgres",
  hostname: System.get_env("POSTGRES_HOST") || "localhost",
  port: System.get_env("POSTGRES_PORT") || "5432",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :wallaby_example_app, WallabyExampleAppWeb.Endpoint,
  http: [port: 4002],
  server: true

config :wallaby, driver: Wallaby.Experimental.Chrome

# Print only warnings and errors during test
config :logger, level: :warn
