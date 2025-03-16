defmodule Lib do
  @moduledoc """
  Модуль для реализации вспомогательного функционала
  """
  require Logger

  @doc """
  Дата и время для отправки по xml в ШЭП
  """
  def message_date() do
    :calendar.system_time_to_rfc3339(:erlang.system_time(:millisecond), [{:unit, :millisecond}])
  end

  @doc """
  Получает точную Дату со Временем по локальному UTC
  """
  def local_datetime() do
    NaiveDateTime.new!(local_date(), local_time())
  end

  @doc """
  Получает точное Время по локальному UTC
  """
  def local_time() do
    {_date, time} = :calendar.local_time()
    Time.from_erl!(time)
  end

  @doc """
  Получает точную Дату по локальному UTC
  """
  def local_date() do
    {date, _time} = :calendar.local_time()
    Date.from_erl!(date)
  end

  # @doc """
  # Проводит преобразование ключей в мапах, полученных в результате XmlToMap
  # """
  # def divide_keys(map) do
  #   Enum.map(map, fn {key, value} ->
  #     new_key =
  #       if String.contains?(key, "}") do
  #         [_, new_key] = String.split(key, "}")
  #         new_key
  #       else
  #         key
  #       end

  #     cond do
  #       is_map(value) ->
  #         new_value = divide_keys(value)
  #         {new_key, new_value}

  #       is_bitstring(value) and String.contains?(value, "<") ->
  #         new_value =
  #           value
  #           |> String.trim()
  #           |> String.replace("\n", "")
  #           |> String.replace("  ", "")
  #           |> XmlToMap.naive_map()
  #           |> divide_keys()

  #         {new_key, new_value}

  #       true ->
  #         {new_key, value}
  #     end
  #   end)
  #   |> Map.new()
  #   |> IO.inspect(label: "data")
  # end

  @doc """
  Получает значение ключа из мапы. Принимает мапу, в котором нужно проводить поиск
  и ключ, который нужно найти в мапе. Возвращает список полученных значений по ключу
  """
  def get_value_of_key_from_map(map, key) do
    Enum.reduce(map, [], fn {k, v}, acc ->
      if k == key do
        [v | acc]
      else
        if is_map(v) do
          get_value_of_key_from_map(v, key)
        else
          acc
        end
      end
    end)
  end

  @doc """
  Преобразовывает ошибки из Ecto.Changeset в строку
  """
  def changeset_error_display(changeset) do
    err_list =
      Ecto.Changeset.traverse_errors(changeset, fn msg ->
        msg
      end)
      |> Enum.reduce([], fn {key, [{msg, _} | _]}, acc ->
        ["Ошибка в поле #{key} с сообщением ошибки #{msg}" | acc]
      end)

    if Enum.count(err_list) < 1 do
      changeset
    else
      Logger.error(inspect(err_list))
      {:error, err_list}
    end
  end

  @doc """
  Проверяет на наличие необходимых ключей в изменениях changeset при записи данных.
  Принимает changeset и ключи для проверки изменений в виде списка атомов ключей.
  На выходе отдает значения в виде кортежей {changeset, true} или {changeset, false}
  """
  def get_changeset_changes(changeset, keys) do
    nil_existance =
      Enum.map(keys, fn key ->
        Enum.find(changeset.changes, fn {k, _v} ->
          k == key
        end)
      end)
      |> Enum.find(&(&1 == nil))

    if is_nil(nil_existance) do
      {changeset, false}
    else
      {changeset, true}
    end
  end

  @doc """
  Приводит полученную map в удобный формат для Elixir
  """
  def normalize_map(nil), do: %{}

  def normalize_map(map) when is_struct(map) do
    Map.from_struct(map)
    |> normalize_map()
  end

  def normalize_map(map) when is_map(map) do
    Map.new(map, fn {key, val} ->
      {
        if(is_atom(key), do: key, else: String.to_atom(key)),
        if(is_map(val) or is_list(val), do: normalize_map(val), else: val)
      }
    end)
  end

  def normalize_map(list) when is_list(list),
    do: Enum.map(list, fn item -> normalize_map(item) end)

  @doc """
  Делает проверку по получению многочисленных данных из LicenseGate.Repo.all()
  """
  def repo_all_case(query_resp, error_msg) do
    case query_resp do
      list when is_list(list) ->
        {:ok, list}

      {:error, reason} ->
        Logger.error("#{error_msg}: #{inspect(reason)}")
        {:error, reason}
    end
  end

  @doc """
  Делает проверку по получению одной записи из LicenseGate.Repo.one()
  """
  def repo_one_case(query_resp, error_msg) do
    case query_resp do
      nil ->
        {:ok, "Нет записи"}

      struct when is_struct(struct) ->
        {:ok, struct}

      {:error, reason} ->
        Logger.error("#{error_msg}: #{inspect(reason)}")
        {:error, reason}
    end
  end

  # @doc """
  # Получает значение ключа из xml
  # """
  # def get_value_from_xml(xml, key) do
  #   xml
  #   |> XmlToMap.naive_map()
  #   |> normalize_map()
  #   |> get_value_of_key_from_map(key)
  # end

  # @doc """
  # Превращает формат NaiveDateTime в стринговую DateTime с таймзоной
  # """
  # def naive_datetime_to_datetime(naive_datetime) do
  #   naive_datetime
  #   |> DateTime.from_naive!("Asia/Almaty")
  #   |> Timex.format!("%FT%T%:z", :strftime)
  # end

  # Делает проверку на наличие обязательных полей, так как мы должны записывать все чеки
  def check_required_fields(map, keys) do
    resp =
      Enum.map(keys, fn key ->
        Map.has_key?(map, key)
      end)
      |> Enum.find(&(&1 == false))

    if is_nil(resp) do
      true
    else
      resp
    end
  end

  @doc """
  Проверяет на наличие значений в ключах мапы
  """
  def check_key_value_list(map, keys) do
    resp =
      Enum.map(keys, fn key ->
        value = Map.get(map, key)
        check_value(value) |> IO.inspect(label: "#{key}")
      end)
      |> IO.inspect(label: "list")
      |> Enum.find(&(&1 == false))

    if is_nil(resp) do
      true
    else
      resp
    end
  end

  defp check_value(nil), do: false

  defp check_value(""), do: false

  defp check_value(value) when is_bitstring(value) do
    IO.inspect("string")
    value
  end

  defp check_value(value) when is_integer(value) do
    IO.inspect("integer")
    value
  end

  defp check_value(value) when is_boolean(value) do
    IO.inspect("boolean")
    value
  end

  defp check_value(value) when is_atom(value) do
    IO.inspect("atom")
    value
  end

  defp check_value(value) when is_float(value) do
    IO.inspect("float")
    value
  end

  defp check_value([]), do: false

  defp check_value(value) when is_list(value) do
    IO.inspect("list")
    value
  end

  defp check_value(value) when is_map(value) do
    IO.inspect("map")

    if Map.values(value) == [] do
      false
    else
      value
    end
  end

  def url_regex(), do: "~r/^https?:\/\/(?:www\.)?[\w.-]+\.[a-z]{2,6}\/[\w.-]+\.(jpeg|jpg|png|gif|webp)$/
"
end
