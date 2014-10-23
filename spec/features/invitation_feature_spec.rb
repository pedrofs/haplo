require 'spec_helper'

describe "invitation feature", type: :feature do
  let!(:account) { create(:account_with_schema) }
  let(:user) { account.owner }

  context "without a logged in user" do
    before(:each) do
      page.driver.header('X-User-Email', nil)
      page.driver.header('X-User-Token', nil)
    end

    it "should not create the invitation" do
      page.driver.post user_invitation_url(subdomain: account.subdomain),
                       user: { email: 'pedro@fsteim.com' },
                       format: :json

      expect(page.driver.response.status).to eq(401)
    end

    it "should accept invitation" do
      invitation_token = create_invitation(account.subdomain, user, 'pedro@fsteim.com')
      page.driver.put user_invitation_url(subdomain: account.subdomain),
                       user: { name: 'Invited Test User', password: '123', password_confirmation: '123', invitation_token: invitation_token },
                       format: :json

      invited_user = User.find_by email: 'pedro@fsteim.com'

      expect(page.driver.response.status).to eq(200)
      expect(invited_user.name).to eq('Invited Test User')
      expect(invited_user.invitation_accepted_at).to_not be_nil
    end
  end

  context "with a logged in user" do
    before(:each) do
      set_auth_request(page.driver, user)
    end

    it "should create the invitation" do
      page.driver.post user_invitation_url(subdomain: account.subdomain),
                       user: { email: 'pedro@fsteim.com' },
                       format: :json

      response_body = JSON.parse(page.driver.response.body)

      expect(page.driver.response.status).to eq(201)
      expect(response_body["email"]).to eq('pedro@fsteim.com')
    end

    it "should send invitation email after creating invitation" do
      page.driver.post user_invitation_url(subdomain: account.subdomain),
                       user: { email: 'pedro@fsteim.com' },
                       format: :json

      open_email 'pedro@fsteim.com'

      invited_user = User.find_by(email: 'pedro@fsteim.com')

      expect(invited_user.name).to be(nil)
      expect(invited_user.email).to eq('pedro@fsteim.com')
      expect(invited_user.password).to be(nil)

      expect(current_email.body).to have_content('Aceitar convite')
      expect(current_email.body).to have_content('pedro@fsteim.com')
    end

    it "should not create invitation without providing email" do
      page.driver.post user_invitation_url(subdomain: account.subdomain),
                       user: { email: '' },
                       format: :json

      response_body = JSON.parse(page.driver.response.body)

      expect(page.driver.response.status).to eq(422)
      expect(response_body["errors"].first).to eq(["email", ["can't be blank"]])
    end
  end
end

def create_invitation subdomain, user, email
  set_auth_request(page.driver, user)

  page.driver.post user_invitation_url(subdomain: account.subdomain),
    user: { email: email },
    format: :json

  user.authentication_token = nil
  set_auth_request(page.driver, user)

  open_email email
  
  current_email.body.match(/\/confirm-invitation\/(\S+)">Aceitar/)[1]
end
