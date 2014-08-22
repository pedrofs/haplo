require 'spec_helper'

describe "subdomains feature", type: :feature do
    let!(:account) { create(:account_with_schema) }

    it "should redirect if subdomain is invalid" do
      page.driver.get timeline_url(subdomain: 'random-subdomain')

      expect(page.driver.response.status).to eq(404)
    end

    it "should allow valid subdomain" do
      page.driver.header('X-User-Email', account.owner.email)
      page.driver.header('X-User-Token', account.owner.authentication_token)

      page.driver.get timeline_url(subdomain: account.subdomain, format: :json)

      expect(page.driver.response.status).to eq(200)
    end
end