require 'spec_helper'

describe "User API", type: :api do
  let(:user) { build(:logged_user) }
  let!(:account) { create(:account_with_schema, subdomain: ApiHelper::SUBDOMAIN, owner: user) }

  before :each do
    set_header user
  end

  
  describe "GET /task_statuses/:id" do
    it "should return 404 for a non existant user" do
      get "/users/1337", format: :json

      expect(last_response.status).to be(404)
    end

    it "should return 200 for a valid user" do
      get "/users/#{user.id}", format: :json

      expect(last_response.status).to be(200)
      expect(JSON::parse(last_response.body)["id"]).to be(user.id)
    end
  end

  describe "PUT /users/:id" do
    it "should return 200 for a valid user" do
      put "/users/#{user.id}", user: {name: 'edited'}, format: :json

      expect(last_response.status).to be(200)
      expect(JSON.parse(last_response.body)["name"]).to eq('edited')
      on_schema account.subdomain do
        expect(User.find_by(id: user.id).try(:name)).to eq('edited')
      end
    end

    it "should return 404 for a non existant user" do
      put "/users/1337", format: :json

      expect(last_response.status).to be(404)
    end
  end
end