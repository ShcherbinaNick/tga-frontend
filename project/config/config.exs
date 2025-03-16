import Config

config :project,
  ecto_repos: [Project.Repo]

config :project, Project.Repo,
  database: "project_db",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool_size: 10
