defmodule SportDataServer.Mixfile do
  use Mix.Project

  def project do
    [
      app: :sport_data_server,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {SportDataServer.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.4"},
      {:phoenix_pubsub, "~> 1.0"},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},
      {:nimble_csv, "~> 0.3"},
      {:timex, "~> 3.1"},
      {:dialyxir, "~> 1.0.0-rc.3", only: [:dev], runtime: false},
      {:exprotobuf, "~> 1.2.9"},
      {:trailing_format_plug, "~> 0.0.7"},
      {:bureaucrat, "~> 0.2.4"}
    ]
  end
end
