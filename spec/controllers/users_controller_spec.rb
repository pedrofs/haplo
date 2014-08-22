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
  end
end