defmodule PriceCheckWeb.Api.TestController do
  use PriceCheckWeb, :controller

  def fetch_html(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        {:error, "Request failed with status code #{status_code}"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "Request failed with reason #{inspect(reason)}"}
    end
  end

  def extract_price_carrefour(body_website) do
    {:ok, html} = Floki.parse_document(body_website)
    html |> Floki.find("main section.container article aside section div")


    Floki.text(html)
    # html
    # |> Floki.find(".text-blue .font-bold")
    # |> Floki.text()
    # |> String.trim()
    # |> case do
    #   "" -> {:error, "Price not found"}
    #   price -> {:ok, price}
    # end
  end

  def index(conn, _params) do
    url = "https://mercado.carrefour.com.br/arroz-branco-longo-fino-tipo-1-tio-joao-5-kg/p"
    {status, body} = fetch_html(url)
    # {status_price, price} =
    json(conn, %{price: extract_price_carrefour(body)})
  end

end
