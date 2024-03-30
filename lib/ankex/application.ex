defmodule Ankex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AnkexWeb.Telemetry,
      Ankex.Repo,
      {DNSCluster, query: Application.get_env(:ankex, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Ankex.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Ankex.Finch},
      # Start a worker by calling: Ankex.Worker.start_link(arg)
      # {Ankex.Worker, arg},
      # Start to serve requests, typically the last entry
      AnkexWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ankex.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AnkexWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
