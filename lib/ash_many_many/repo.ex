defmodule AshManyMany.Repo do
  use AshPostgres.Repo,
    otp_app: :ash_many_many

  # Installs Postgres extensions that ash commonly uses
  def installed_extensions do
    ["uuid-ossp", "citext"]
  end
end
