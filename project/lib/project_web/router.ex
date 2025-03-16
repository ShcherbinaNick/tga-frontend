defmodule Project.Router do
  use Plug.Router
  require Logger

  plug(CORSPlug,
    origin: ["http://localhost:5173"]
  )

  alias Repository.{Description, Products, Slider}

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Poison
  )

  plug(:match)
  plug(:dispatch)

  get "/slider" do
    Slider.get_all()
    |> case do
      {:ok, sliders} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, sliders |> Poison.encode!() |> IO.inspect(label: "slider"))

      {:error, reason} ->
        send_resp(conn, 400, reason)
    end
  end

  get "/products" do
    Products.get_all()
    |> case do
      {:ok, products} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, products |> Poison.encode!() |> IO.inspect(label: "products"))

      {:error, reason} ->
        send_resp(conn, 400, reason)
    end
  end

  get "/descriptions" do
    IO.inspect(conn.query_params, label: "body_params")

    product_id = conn.query_params |> Lib.normalize_map() |> Map.get(:product_id)

    IO.inspect(product_id, label: "product_id")

    case Description.get_by_product_id(product_id) do
      {:ok, descriptions} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, descriptions |> Poison.encode!())

      {:error, message} ->
        send_resp(conn, 400, message)
    end
  end
end
