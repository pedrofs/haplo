require 'spec_helper'

describe "FavoriteProjects API", type: :api do
  let(:user) { build(:logged_user) }
  let!(:account) { create(:account_with_schema, subdomain: ApiHelper::SUBDOMAIN, owner: user) }
  let!(:project) { create_on_schema :project, account.subdomain }

  before :each do
    set_header user
  end

  describe "GET /favorite_projects.json" do
    it "should return 200 and no projects" do
      get "/favorite_projects.json", {}, format: :json

      expect(last_response.status).to be(200)
      expect(JSON::parse(last_response.body).count).to be(0)
    end

    it "should return 200 and one project" do
      on_schema account.subdomain do
        create(:favorite_project, user_id: user.id, project_id: project.id)
      end

      get "/favorite_projects.json", {}, format: :json

      expect(last_response.status).to be(200)
      expect(JSON::parse(last_response.body).count).to be(1)
    end
  end

  describe "GET /users/:user_id/favorite_projects.json" do
    it "should return 200 and no projects" do
      get "/users/#{user.id}/favorite_projects.json", {}, format: :json

      expect(last_response.status).to be(200)
      expect(JSON::parse(last_response.body).count).to be(0)
    end

    it "should return 200 and one project" do
      on_schema account.subdomain do
        create(:favorite_project, user_id: user.id, project_id: project.id)
      end

      get "/users/#{user.id}/favorite_projects.json", {}, format: :json

      expect(last_response.status).to be(200)
      expect(JSON::parse(last_response.body).count).to be(1)
    end
  end

  describe "POST /favorite_projects/toggle/:projectId.json" do
    it "should return 201 with valid project id" do
      post "/favorite_projects/toggle/#{project.id}.json", {}, format: :json
      expect(last_response.status).to be(201)
    end

    it "should return 404 with invalid project id" do
      post "/favorite_projects/toggle/1337.json", {}, format: :json
      expect(last_response.status).to be(404)
    end

    it "should return 204 and favorite set as false when `unfavorite`" do
      on_schema account.subdomain do
        favorite_project = create(:favorite_project, {user_id: user.id, project_id: project.id})
      end

      post "/favorite_projects/toggle/#{project.id}.json", {}, format: :json
      expect(last_response.status).to be(204)

      on_schema account.subdomain do
        expect(FavoriteProject.find_by(user_id: user.id, project_id: project.id)).to be(nil)
      end
    end
  end
end