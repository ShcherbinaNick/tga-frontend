defmodule Project.Repo.Migrations.ProductDescription do
  use Ecto.Migration

  def change do
    create table "descriptions" do
      add :d_text, :string
      add :photo_link, :string
      add :product_id, references("products", on_delete: :delete_all)

      timestamps()
    end
  end
end
