defmodule Matchum.Repo do
  use Ecto.Repo,
    otp_app: :matchum,
    adapter: Ecto.Adapters.Postgres
end
