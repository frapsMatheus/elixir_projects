defmodule PriceCheck.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PriceCheckWeb.Telemetry,
      PriceCheck.Repo,
      {DNSCluster, query: Application.get_env(:price_check, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PriceCheck.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PriceCheck.Finch},
      # Start a worker by calling: PriceCheck.Worker.start_link(arg)
      # {PriceCheck.Worker, arg},
      # Start to serve requests, typically the last entry
      PriceCheckWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PriceCheck.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PriceCheckWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
