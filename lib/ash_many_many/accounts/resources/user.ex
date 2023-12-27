defmodule AshManyMany.Accounts.User do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "users"
    repo AshManyMany.Repo
  end

  actions do
    defaults [:read]

    create :create do
      primary? true
      accept [:email]

      argument :organisations, {:array, :map}, allow_nil?: true

      change manage_relationship(:organisations, type: :append_and_remove)
    end

    update :update do
      primary? true
      accept [:email]

      argument :organisations, {:array, :map}, allow_nil?: true

      change manage_relationship(:organisations, type: :append_and_remove)
    end
  end

  attributes do
    uuid_primary_key(:id)
    attribute(:email, :string, allow_nil?: false)
  end

  relationships do
    many_to_many :organisations, AshManyMany.Accounts.Organisation do
      through AshManyMany.Accounts.UserOrganisation
      source_attribute_on_join_resource :user_id
      destination_attribute_on_join_resource :organisation_id
    end
  end

  identities do
    identity :unique_email, [:email]
  end

end
