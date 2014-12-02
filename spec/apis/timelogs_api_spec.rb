require 'spec_helper'

describe "Timelogs API", type: :api do
  let(:user) { build(:logged_user) }
  let!(:account) { create(:account_with_schema, subdomain: ApiHelper::SUBDOMAIN, owner: user) }

  before :each do
    set_header user
  end

  describe "GET /timelogs.json" do
    let!(:timelog) { create_on_schema(:timelog, account.subdomain) }

    context "when filtering by user" do
      it 'should return timelogs' do
        get "/timelogs?search[user_id_eq]=#{timelog.user_id}", format: :json
        expect(last_response.status).to eq(200)
        expect(JSON::parse(last_response.body).count).to eq(1)
      end

      it 'should return empty for invalid user' do
        get "/timelogs?search[user_id_eq]=1337", format: :json
        expect(last_response.status).to eq(200)
        expect(JSON::parse(last_response.body).count).to eq(0)
      end
    end

    context "when filtering by project" do
      it 'should return timelogs' do
        get "/timelogs?search[project_id]=#{timelog.task.taskable_id}", format: :json
        expect(last_response.status).to eq(200)
        expect(JSON::parse(last_response.body).count).to eq(1)
      end

      it 'should return empty for invalid project' do
        get "/timelogs?search[project_id]=1337", format: :json
        expect(last_response.status).to eq(200)
        expect(JSON::parse(last_response.body).count).to eq(0)
      end
    end

    context "when filtering by task" do
      it 'should return timelogs' do
        get "/timelogs?search[task_id_eq]=#{timelog.task_id}", format: :json
        expect(last_response.status).to eq(200)
        expect(JSON::parse(last_response.body).count).to eq(1)
      end

      it 'should return empty for invalid task' do
        get "/timelogs?search[task_id_eq]=1337", format: :json
        expect(last_response.status).to eq(200)
        expect(JSON::parse(last_response.body).count).to eq(0)
      end
    end
  end

  describe "POST /timelogs/toggle/:task_id.json" do
    let!(:task) { create_on_schema :task, account.subdomain }

    it "should start the task" do
      post "/timelogs/toggle/#{task.id}", format: :json
      expect(last_response.status).to eq(200)
      expect(JSON::parse(last_response.body)["started_at"]).to_not eq(nil)
      expect(JSON::parse(last_response.body)["stopped_at"]).to eq(nil)
    end

    it "should stop the task" do
      post "/timelogs/toggle/#{task.id}", format: :json
      post "/timelogs/toggle/#{task.id}", format: :json
      expect(last_response.status).to eq(200)
      expect(JSON::parse(last_response.body)["started_at"]).to_not eq(nil)
      expect(JSON::parse(last_response.body)["stopped_at"]).to_not eq(nil)
    end
  end

  describe "PUT /timelogs/:id.json" do
  end

  describe "DELETE /timelogs/:id.json" do
  end
end