defmodule Project.Server do
  def start_link(_) do
    Plug.Cowboy.http(Project.Router, [], port: 4000)
  end
end
