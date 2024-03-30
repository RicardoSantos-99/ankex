defmodule Ankex.Repo do
  use Ecto.Repo,
    otp_app: :ankex,
    adapter: Ecto.Adapters.Postgres
end
