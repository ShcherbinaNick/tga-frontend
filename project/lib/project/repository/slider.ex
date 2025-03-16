defmodule Repository.Slider do
  use Ecto.Schema
  import Ecto.Query
  import Ecto.Changeset

  alias Project.Repo

  require Logger

  schema "slider" do
    field(:title, :string)
    field(:photo_link, :string)

    timestamps()
  end

  def changeset(slider) do
    %__MODULE__{}
    |> cast(slider, [:title, :photo_link])
    |> validate_required([:title, :photo_link])
  end

  def insert(slider) do
    Project.Repo.transaction(fn ->
      slider
      |> changeset()
      |> Project.Repo.insert()
      |> case do
        {:ok, struct} ->
          struct

        {:error, %Ecto.Changeset{} = changeset} ->
          Project.Repo.rollback(changeset)

        {:error, reason} ->
          Logger.error("Ошибка при добавлении данных для слайдера: #{inspect(reason)}")
          {:error, reason}
      end
    end)
  end

  @doc """
  Получение данных для слайдера из таблицы slider по ID
  """
  def get(slider_id) do
    from(
      s in __MODULE__,
      where: s.id == ^slider_id,
      select: %{id: s.id, title: s.title, photo: s.photo_link}
    )
    |> Repo.one()
    |> Lib.repo_one_case("Ошибка при получении данных для слайдера по ID")
  end

  @doc """
  Получает список всех данных для слайдера из таблицы slider
  """
  def get_all() do
    from(
      s in __MODULE__,
      select: %{id: s.id, title: s.title, photo: s.photo_link}
    )
    |> Repo.all()
    |> Lib.repo_all_case("Ошибка при получении списка товаров")
  end
end
