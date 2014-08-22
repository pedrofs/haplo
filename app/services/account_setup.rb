class AccountSetup
  def setup account
    if account.valid?
      create_schema account
    end
  end

  def create_schema account
    Apartment::Tenant.create account.subdomain
    Apartment::Tenant.switch account.subdomain
  end
end