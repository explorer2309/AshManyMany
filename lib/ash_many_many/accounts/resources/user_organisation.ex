defmodule AshManyMany.Accounts.UserOrganisation do
  @moduledoc """
  The join resource between User and Organisation
  """
  use Ash.Resource, data_layer: AshPostgres.DataLayer

  alias AshManyMany.Accounts.User
  alias AshManyMany.Accounts.Organisation

  postgres do
    table "user_organisations"
    repo AshManyMany.Repo

    references do
      reference :user, on_delete: :delete
      reference :organisation, on_delete: :delete
    end
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end

  relationships do
    belongs_to :user, User, primary_key?: true, allow_nil?: false
    belongs_to :organisation, Organisation, primary_key?: true, allow_nil?: false
  end
end
