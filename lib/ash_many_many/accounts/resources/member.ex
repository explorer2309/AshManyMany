defmodule AshManyMany.Accounts.Member do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "members"
    repo AshManyMany.Repo
  end

  actions do
    defaults([:create, :read, :update, :destroy])
  end

  attributes do
    uuid_primary_key(:id)
    attribute(:email, :string, allow_nil?: false)
    attribute(:name, :string, allow_nil?: false)
  end

  relationships do
    belongs_to :organisation, AshManyMany.Accounts.Organisation do
      api AshManyMany.Accounts
      attribute_writable? true
      allow_nil? false
    end

    belongs_to :user, AshManyMany.Accounts.User do
      api AshManyMany.Accounts
      writable? true
      allow_nil? true
    end
  end

  identities do
    identity :unique_email, [:email]
  end

  multitenancy do
    strategy(:context)
  end
end
