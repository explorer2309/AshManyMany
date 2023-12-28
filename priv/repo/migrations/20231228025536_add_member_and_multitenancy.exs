defmodule AshManyMany.Repo.Migrations.AddMemberAndMultitenancy do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_postgres.generate_migrations`
  """

  use Ecto.Migration

  def up do
    drop constraint(:user_organisations, "user_organisations_organisation_id_fkey")

    alter table(:user_organisations) do
      modify :organisation_id,
             references(:organisations,
               column: :id,
               name: "user_organisations_organisation_id_fkey",
               type: :uuid,
               prefix: "public",
               on_delete: :delete_all
             )
    end

    execute(
      "ALTER TABLE user_organisations alter CONSTRAINT user_organisations_organisation_id_fkey NOT DEFERRABLE"
    )
  end

  def down do

    drop constraint(:user_organisations, "user_organisations_organisation_id_fkey")

    alter table(:user_organisations) do
      modify :organisation_id,
             references(:organisations,
               column: :id,
               name: "user_organisations_organisation_id_fkey",
               type: :uuid,
               prefix: "public",
               on_delete: :delete_all
             )
    end
  end
end