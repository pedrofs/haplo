require 'spec_helper'

describe AccountsController, type: :feature do

  describe "POST create" do
    it "should create account" do
      account_attr = attributes_for(:account)

      page.driver.post accounts_url,
                       account: account_attr.merge({owner_attributes: attributes_for(:user)}),
                       format: :json

      expect(page.driver.response.status).to eq(201)
      expect(Account.all.count).to eq(1)
      expect { Apartment::Tenant.switch(account_attr[:subdomain]) }.not_to raise_error
    end

    it "should not create account due to errors on subdomain" do
      page.driver.post accounts_url,
                       account: attributes_for(:invalid_account),
                       format: :json

      expect(page.driver.response.status).to eq(422)
    end

    it "should not allow account creation inside subdomain" do
      account_attr = attributes_for(:account)
      account = create(:account_with_schema)

      expect { page.driver.post accounts_url(subdomain: account.subdomain),
                       account: account_attr.merge({owner_attributes: attributes_for(:user)}),
                       format: :json }.to raise_error ActionController::RoutingError
    end
  end
end