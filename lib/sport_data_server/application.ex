defmodule SportDataServer.Application do
  require Logger
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the endpoint when the application starts
      supervisor(SportDataServerWeb.Endpoint, []),
      SportDataServer.DB,
      {Task, &import_data_file/0}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SportDataServer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SportDataServerWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp import_data_file do
    case Application.get_env(:sport_data_server, :initial_csv_file_path) do
      nil ->
        :noop

      relative_path ->
        file_path = Application.app_dir(:sport_data_server, relative_path)

        file_path
        |> File.stream!()
        |> SportDataServer.CSVImport.import_stream()

        Logger.info("File #{inspect(file_path)} was imported!")
    end
  end
end
