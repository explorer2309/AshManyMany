defmodule AshManyMany.Accounts.Organisation do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "organisations"
    repo AshManyMany.Repo

    manage_tenant do
      template(["org_", :id])
    end
  end

  multitenancy do
    strategy(:attribute)
    attribute(:id)
    global?(true)
    parse_attribute({__MODULE__, :tenant, []})
  end

  def tenant("org_" <> tenant) do
    tenant
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      argument :users, {:array, :map}

      change manage_relationship(:users, type: :append_and_remove)
    end

    update :update do
      primary? true
      accept [:name]

      argument :users, {:array, :map}, allow_nil?: true

      change manage_relationship(:users,type: :append_and_remove)
    end
  end

  attributes do
    uuid_primary_key(:id)
    attribute(:name, :string, allow_nil?: false)
  end

  identities do
    identity :unique_name, [:name]
  end

  relationships do
    many_to_many :users, AshManyMany.Accounts.User do
      through AshManyMany.Accounts.UserOrganisation
      source_attribute_on_join_resource :organisation_id
      destination_attribute_on_join_resource :user_id
    end

    has_many(:members, AshManyMany.Accounts.Member, destination_attribute: :organisation_id)
  end
end
