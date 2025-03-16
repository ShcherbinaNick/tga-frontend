defmodule Project.Repo.Migrations.Products do
  use Ecto.Migration

  def change do
    create table "products" do
      add :title, :string, null: false
      add :photo_link, :string, null: false

      timestamps()
    end
  end
end
