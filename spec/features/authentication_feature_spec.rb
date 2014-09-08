require 'spec_helper'

describe "authentication feature", type: :feature do
  describe "sign in" do
    let(:user) { build(:user) }
    let!(:account) { create(:account_with_schema, owner: user) }

    it "should allow user sign in" do
      sign_user_in(user, subdomain: account.subdomain)

      response_body = JSON.parse(page.driver.response.body)

      expect(response_body["authentication_token"]).not_to be_nil
      expect(response_body["password"]).to be_nil
      expect(response_body["email"]).not_to be_nil
      expect(page.driver.response.status).to eq(200)
    end

    it "should not allow user to sign in without a domain" do
      expect {
        sign_user_in(user, subdomain: nil)
      }.to raise_error ActionController::RoutingError
    end

    it "should not allow invalid user sign in" do
      sign_user_in(user, subdomain: account.subdomain, password: 'WrongOne')

      expect(page.driver.response.status).to eq(401)
    end

    it "should not allow user from one subdomain to log in on another subdomain" do
      user2 = build(:user)
      account2 = create(:account_with_schema, owner: user2)

      sign_user_in(user2, subdomain: account2.subdomain)
      expect(page.driver.response.status).to eq(200)

      sign_user_in(user2, subdomain: account.subdomain)
      expect(page.driver.response.status).to eq(401)
    end
  end

  describe "sign out" do
    it "should sign out the user" do
      user = create(:user, email: 'test@test.com', password: '123', authentication_token: 'test')

      set_auth_request(page.driver, user)

      page.driver.delete destroy_user_session_url

      expect(page.driver.response.status).to eq(204)
      expect(User.first.authentication_token).to be_nil
    end
  end
end
