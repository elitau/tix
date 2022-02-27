import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :wallaby_example_app, WallabyExampleApp.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "wallaby_example_app_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :wallaby_example_app, WallabyExampleAppWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "6r4ezT0xblK1auhk368xc2Yh8SOSY9885UE9QBVZYBXJ7cwDl+1GCHFw7p1IZl1j",
  server: false

# In test we don't send emails.
config :wallaby_example_app, WallabyExampleApp.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
config :wallaby, otp_app: :wallaby_example_app
config :wallaby_example_app, WallabyExampleAppWeb.Endpoint, server: true
