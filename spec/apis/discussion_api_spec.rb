require 'spec_helper'

describe "Discussion API", type: :api do
  let(:user) { build(:logged_user) }
  let!(:account) { create(:account_with_schema, subdomain: ApiHelper::SUBDOMAIN, owner: user) }

  before :each do
    set_header user
  end

  describe "GET /discussions" do
    it "should render 404 if no targetable neither user are provided" do
      get "/discussions", format: :json
      expect(last_response.status).to eq(404)
    end

    describe "when asking for a targetable" do
      let!(:project) { create_on_schema :project, account.subdomain }

      it "should return empty discussions" do
        get "/discussions?targetable_id=#{project.id}&targetable_type=Project", format: :json

        expect(last_response.status).to eq(200)
        expect(JSON::parse(last_response.body).count).to eq(0)
      end

      it "should return one discussion" do
        on_schema account.subdomain do
          discussion = build(:discussion)
          discussion.build_targets_from_targetable project
          discussion.save!
        end

        get "/discussions?targetable_id=#{project.id}&targetable_type=Project", format: :json

        expect(last_response.status).to eq(200)
        expect(JSON::parse(last_response.body).count).to eq(1)
      end

      it "should return two discussions" do
        on_schema account.subdomain do
          task = build(:task_with_users_and_project, taskable_id: project.id, taskable_type: 'Project')
          task.save!
          discussion = build(:discussion)
          discussion.build_targets_from_targetable task
          discussion.save!

          discussion2 = build(:discussion, content: 'TESSSSTTTTTIIIINNNG')
          discussion2.build_targets_from_targetable project
          discussion2.save!
        end

        get "/discussions?targetable_id=#{project.id}&targetable_type=Project", format: :json

        expect(last_response.status).to eq(200)
        expect(JSON::parse(last_response.body).count).to eq(2)
      end
    end

    describe "when asking for a user" do
      let!(:project) { create_on_schema :project, account.subdomain }

      it "should return empty discussions" do
        get "/discussions?user_id=#{user.id}", format: :json

        expect(last_response.status).to eq(200)
        expect(JSON::parse(last_response.body).count).to eq(0)
      end

      it "should return one discussions" do
        on_schema account.subdomain do
          discussion = build(:discussion, user_id: user.id)
          discussion.build_targets_from_targetable project
          discussion.save!
        end

        get "/discussions?user_id=#{user.id}", format: :json

        expect(last_response.status).to eq(200)
        expect(JSON::parse(last_response.body).count).to eq(1)
      end

      it "should return two discussions" do
        on_schema account.subdomain do
          task = build(:task_with_users_and_project, taskable_id: project.id, taskable_type: 'Project')
          task.save!
          discussion = build(:discussion, user_id: user.id)
          discussion.build_targets_from_targetable task
          discussion.save!

          discussion2 = build(:discussion, content: 'TESSSSTTTTTIIIINNNG', user_id: user.id)
          discussion2.build_targets_from_targetable project
          discussion2.save!
        end

        get "/discussions?user_id=#{user.id}", format: :json

        expect(last_response.status).to eq(200)
        expect(JSON::parse(last_response.body).count).to eq(2)
      end
    end
  end

  describe "POST /discussions" do
    let!(:project) { create_on_schema :project, account.subdomain }
    it "should return 201 with flash and create one target" do
      discussion = attributes_for(:discussion, user_id: user.id)
      post "/discussions", {discussion: discussion, targetable_id: project.id, targetable_type: 'Project'}, format: :json
      expect(last_response.status).to eq(201)
      expect(JSON::parse(last_response.body)["flash"]).to eq("Discussão criada com sucesso.")
      expect(JSON::parse(last_response.body)["status"]).to eq("success")
    end

    it "should return 201 with flash and create two target" do
      discussion = attributes_for(:discussion, user_id: user.id)
      post "/discussions", {discussion: discussion, targetable_id: project.id, targetable_type: 'Project'}, format: :json
      expect(last_response.status).to eq(201)
      expect(JSON::parse(last_response.body)["flash"]).to eq("Discussão criada com sucesso.")
      expect(JSON::parse(last_response.body)["status"]).to eq("success")
    end

    it "should not create discussion with invalid arguments" do
      discussion = attributes_for(:discussion, content: nil)
      post "/discussions", {discussion: discussion, targetable_id: project.id, targetable_type: 'Project'}, format: :json
      expect(last_response.status).to eq(422)
      expect(JSON::parse(last_response.body)["errors"]).to have_key("content")
    end

    it "should return 404 if the targetable_type isn't a Targetable" do
      discussion = attributes_for(:discussion)
      post "/discussions", {discussion: discussion, targetable_id: project.id, targetable_type: 'User'}, format: :json
      expect(last_response.status).to eq(404)
    end

    it "should return 404 if the targetable_type a valid class" do
      discussion = attributes_for(:discussion)
      post "/discussions", {discussion: discussion, targetable_id: project.id, targetable_type: 'InvalidClass'}, format: :json
      expect(last_response.status).to eq(404)
    end
  end

  describe "GET /discussions/:id" do
    let!(:discussion) { create_on_schema :discussion, account.subdomain }

    it "should return 200 when discussion exists" do
      get "/discussions/#{discussion.id}", format: :json
      expect(last_response.status).to eq(200)
      expect(JSON::parse(last_response.body)["content"]).to eq(discussion.content)
    end

    it "should return 404 when discussion doesn't exist" do
      get "/discussions/1337", format: :json
      expect(last_response.status).to eq(404)
    end
  end

  describe "PUT /discussions/:id" do
    let!(:discussion) { create_on_schema :discussion, account.subdomain }

    it "should edit the discussion" do
      put "/discussions/#{discussion.id}", {discussion: {content: 'testing'}}, format: :json
      expect(last_response.status).to eq(200)
      expect(JSON::parse(last_response.body)["discussion"]["content"]).to eq('testing')
      expect(JSON::parse(last_response.body)["flash"]).to eq('Discussão alterada com sucesso.')
      expect(JSON::parse(last_response.body)["status"]).to eq('success')
    end

    it "should not edit the discussion with invalid attributes" do
      put "/discussions/#{discussion.id}", {discussion: {content: ''}}, format: :json
      expect(last_response.status).to eq(422)
      expect(JSON::parse(last_response.body)).to have_key("errors")
    end
  end

  describe "DELETE /discussions/:id" do
    let!(:discussion) { create_on_schema :discussion, account.subdomain }

    it "should destroy the discussion" do
      delete "/discussions/#{discussion.id}", format: :json
      expect(last_response.status).to eq(200)
      expect(JSON::parse(last_response.body)["flash"]).to eq("Discussão removida com sucesso.")
      expect(JSON::parse(last_response.body)["status"]).to eq("success")
    end

    it "should render 404 for a invalid discussion" do
      delete "/discussions/1337", format: :json
      expect(last_response.status).to eq(404)
    end
  end
end