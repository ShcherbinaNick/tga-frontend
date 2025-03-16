defmodule Insertion do
  def insert() do
    [
      %{
        title: "Муфты Термоусаживаемые для ППУ изоляция + КЗС",
        photo_link: "https://i.imgur.com/n4yoAa9.jpeg",
        inserted_at: ~N[2025-03-03 07:32:24],
        updated_at: ~N[2025-03-03 07:32:24]
      },
      %{
        title: "Трубы ГПИ и фитинги",
        photo_link: "https://i.imgur.com/fW6EY2X.jpeg",
        inserted_at: ~N[2025-03-03 07:31:19],
        updated_at: ~N[2025-03-03 07:31:19]
      },
      %{
        title: "Электронные счётчики газа и промышленные расходомеры",
        photo_link: "https://i.imgur.com/SQhc1LR.jpeg",
        inserted_at: ~N[2025-03-03 07:33:18],
        updated_at: ~N[2025-03-03 07:33:18]
      },
      %{
        title: "Газовое оборудование",
        photo_link: "https://i.imgur.com/dF1KiZc.jpeg",
        inserted_at: ~N[2025-03-03 07:32:57],
        updated_at: ~N[2025-03-03 07:32:57]
      }
    ]
    |> Enum.map(&Repository.Slider.insert(&1))

    [
      %{
        title: "Муфты Термоусаживаемые и КЗС",
        photo_link: "https://imgur.com/9dMc4QG"
      },
      %{
        title: "ГПИ трубы",
        photo_link: "https://imgur.com/Ma49kLl"
      },
      %{
        title: "Электронные Счётчики Газа \"Гранд\"",
        photo_link: "https://imgur.com/Gn7hQJR"
      },
      %{
        title: "Газовое оборудование, ГРПШ, Фильтра",
        photo_link: "https://imgur.com/6udhzIY"
      },
      %{
        title: "Взрывозащищённое оборудование и КИПиА",
        photo_link: "https://imgur.com/IO9lvYn"
      },
      %{
        title: "Сливо-наливное оборудование",
        photo_link: "https://imgur.com/IUKiDKn"
      }
    ]
    |> Enum.map(&Repository.Products.insert(&1))
  end
end
