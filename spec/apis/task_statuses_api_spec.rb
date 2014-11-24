require 'spec_helper'

describe "Tasks Status API", type: :api do
  let(:user) { build(:logged_user) }
  let!(:account) { create(:account_with_schema, subdomain: ApiHelper::SUBDOMAIN, owner: user) }

  before :each do
    set_header user
  end

  describe "GET /index" do
    it "should return the right statuses set" do
      get '/task_statuses', format: :json
      expect(JSON::parse(last_response.body)).to eq(Task::STATUSES)
      expect(last_response.status).to be(200)
    end
  end
end