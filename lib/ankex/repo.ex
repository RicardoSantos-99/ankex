defmodule Ankex.Repo do
  @moduledoc false
  use Ecto.Repo,
    otp_app: :ankex,
    adapter: Ecto.Adapters.Postgres
end
