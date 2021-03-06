use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sport_data_server, SportDataServerWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :sport_data_server, initial_csv_file_path: nil
