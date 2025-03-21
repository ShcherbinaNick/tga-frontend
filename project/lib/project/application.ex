defmodule Project.Application do
  use Application
  @impl true
  def start(_type, _args) do
    children = [
      Project.Repo,
      {Plug.Cowboy, scheme: :http, plug: Project.Router, options: [ip: {0, 0, 0, 0}, port: 4000]}

    ]

    opts = [strategy: :one_for_one, name: Project.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
