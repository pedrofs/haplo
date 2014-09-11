require 'spec_helper'

describe UsersController, type: :feature do
  let!(:account) { create(:account_with_schema) }
  let(:user) { account.owner }

  describe "GET index" do
    it "should return users json" do
      set_auth_request(page.driver, user)
      page.driver.get users_url(subdomain: account.subdomain), format: :json

      expect(page.driver.response.status).to eq(200)
      users = JSON.parse(page.driver.response.body)

      expect(users.count).to eq(1)
      expect(users.first["status"]).to eq(true)
    end

    # it "should not delete the owner user" do
    #   set_auth_request(page.driver, user)
    #   page.driver.delete users_url(not_created_user, { subdomain: account.subdomain }), format: :json
    #   expect(page.driver.response.status).to eq(401)
    # end

    # it "should delete an user" do
    #   Apartment::Tenant.switch account.subdomain
    #   created_user = create(:user)
    #   Apartment::Tenant.reset

    #   set_auth_request(page.driver, user)
    #   page.driver.delete users_url(created_user, { subdomain: account.subdomain }), format: :json
    #   expect(page.driver.response.status).to eq(200)
    # end

    # it "should not delete an invalid user" do
    #   set_auth_request(page.driver, user)
    #   not_created_user = build(:user)
    #   page.driver.delete users_url(not_created_user, { subdomain: account.subdomain }), format: :json
    #   expect(page.driver.response.status).to eq(404)
    # end

    # it "should not delete an user logged out" do
    #   not_created_user = build(:user)
    #   page.driver.delete users_url(not_created_user, { subdomain: account.subdomain }), format: :json
    #   expect(page.driver.response.status).to eq(401)
    # end
  end
end