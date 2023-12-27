defmodule AshManyMany.Accounts do
  use Ash.Api,
    otp_app: :ash_many_many,
    extensions: [AshAdmin.Api]

  admin do
    show? true
  end

  authorization do
    authorize :by_default
  end

  resources do
    resource AshManyMany.Accounts.User
    resource AshManyMany.Accounts.Organisation
    resource AshManyMany.Accounts.UserOrganisation
  end
end
