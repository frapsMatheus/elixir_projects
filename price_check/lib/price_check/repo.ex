defmodule PriceCheck.Repo do
  use Ecto.Repo,
    otp_app: :price_check,
    adapter: Ecto.Adapters.Postgres
end
