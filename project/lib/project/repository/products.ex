defmodule Repository.Products do
  use Ecto.Schema
  import Ecto.Query
  import Ecto.Changeset

  alias Project.Repo

  require Logger

  schema "products" do
    field(:title, :string)
    field(:photo_link, :string)

    has_many(:descriptions, {"descriptions", Repository.Description}, foreign_key: :product_id)

    timestamps()
  end

  def changeset(item) do
    %__MODULE__{}
    |> cast(item, [:title, :photo_link])
    |> validate_required([:title, :photo_link])
  end

  def insert(product) do
    Project.Repo.transaction(fn ->
      product
      |> changeset()
      |> Project.Repo.insert()
      |> case do
        {:ok, struct} ->
          struct

        {:error, %Ecto.Changeset{} = changeset} ->
          Project.Repo.rollback(changeset)
          {:error, "Ошибка при добавлении товара"}

        {:error, reason} ->
          Logger.error("Ошибка при добавлении товара: #{inspect(reason)}")
          {:error, reason}
      end
    end)
  end

  @doc """
  Получение товара из таблицы products по ID
  """
  def get(product_id) do
    descriptions_preload = descriptions_preload()

    from(
      p in Repository.Products,
      where: p.id == ^product_id,
      preload: [descriptions: ^descriptions_preload],
      select: p
    )
    |> Repo.one()
    |> Lib.repo_one_case("Ошибка при получении описания по ID")
  end

  # Функция прелоада для списка описании связанных с товаром
  defp descriptions_preload() do
    from(
      d in Repository.Description,
      select: %{text: d.d_text, photo_link: d.photo_link, id: d.id}
    )
  end

  @doc """
  Получает список всех товаров из таблицы products
  """
  def get_all() do
    from(
      p in __MODULE__,
      select: %{id: p.id, title: p.title, photo: p.photo_link}
    )
    |> Repo.all()
    |> Lib.repo_all_case("Ошибка при получении списка товаров")
  end
end
