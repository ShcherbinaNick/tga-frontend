defmodule Project.Repo.Migrations.Slider do
  use Ecto.Migration

  def change do
    create table "slider" do
      add :title, :string
      add :photo_link, :string

      timestamps()
    end
  end
end
