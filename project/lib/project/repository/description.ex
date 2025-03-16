defmodule Repository.Description do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  require Logger

  alias Project.Repo

  schema "descriptions" do
    field(:d_text, :string)
    field(:photo_link, :string)

    belongs_to(:product, Repository.Products)

    timestamps()
  end

  def changeset(description) do
    %__MODULE__{}
    |> cast(description, [:d_text, :photo_link, :product_id])
    |> validate_required([:d_text, :photo_link, :product_id])
  end

  @doc """
  Запись описания в таблицу description
  """
  def insert(description) do
    Repo.transaction(fn ->
      description
      |> changeset()
      |> Repo.insert()
      |> case do
        {:ok, struct} ->
          struct

        {:error, %Ecto.Changeset{} = changeset} ->
          Logger.error("Ошибка при записи описания товара: #{inspect(changeset)}")
          Repo.rollback(changeset)

        {:error, reason} ->
          Logger.error(reason)
          {:error, reason}
      end
    end)
  end

  @doc """
  Получение описания из таблицы description по ID
  """
  def get(description_id) do
    from(
      d in __MODULE__,
      where: d.id == ^description_id,
      select: d
    )
    |> Repo.one()
    |> Lib.repo_one_case("Ошибка при получении описания по ID")
  end

  @doc """
  Получает список всех описании по ID товара в таблице descriptionsj
  """
  def get_by_product_id(product_id) do
    from(
      d in __MODULE__,
      where: d.product_id == ^product_id,
      select: %{id: d.id, text: d.d_text, photo: d.photo_link}
    )
    |> Repo.all()
    |> Lib.repo_all_case("Ошибка при получении список всех описании товара")
  end
end
