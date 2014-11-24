require 'spec_helper'

describe "Tasks API", type: :api do
  let(:user) { build(:logged_user) }
  let!(:account) { create(:account_with_schema, subdomain: ApiHelper::SUBDOMAIN, owner: user) }

  before :each do
    set_header user
  end

  context "methods that do not require nested controller" do
    let!(:project) { create_on_schema :project, account.subdomain }
    let!(:task) { build(:task, taskable: project, assigned: user, reporter: user) }

    describe "PUT /tasks/:id/change_status/:status" do
      before :each do
        on_schema account.subdomain do
          task.save
        end
      end

      it "should close the task" do
        put "/tasks/#{task.id}/change_status/close", format: :json
        expect(last_response.status).to be(200)
        expect(JSON::parse(last_response.body)["status"]).to be(2)
        on_schema account.subdomain do
          expect(Task.find(task.id).status).to be(Task::CLOSED)
        end
      end

      it "should reopen the task" do
        put "/tasks/#{task.id}/change_status/reopen", format: :json
        expect(last_response.status).to be(200)
        expect(JSON::parse(last_response.body)["status"]).to be(3)
        on_schema account.subdomain do
          expect(Task.find(task.id).status).to be(Task::REOPENED)
        end
      end

      it "should resolve the task" do
        put "/tasks/#{task.id}/change_status/resolve", format: :json
        expect(last_response.status).to be(200)
        expect(JSON::parse(last_response.body)["status"]).to be(1)
        on_schema account.subdomain do
          expect(Task.find(task.id).status).to be(Task::RESOLVED)
        end
      end

      it "should archive the task" do
        put "/tasks/#{task.id}/change_status/archive", format: :json
        expect(last_response.status).to be(200)
        expect(JSON::parse(last_response.body)["status"]).to be(4)
        on_schema account.subdomain do
          expect(Task.find(task.id).status).to be(Task::ARCHIVED)
        end
      end

      it "should return 404 for an unknown status" do
        put "/tasks/#{task.id}/change_status/unknown", format: :json
        expect(last_response.status).to be(404)
      end

      it "should return 404 for an unknown task" do
        put "/tasks/1337/change_status/unknown", format: :json
        expect(last_response.status).to be(404)
      end
    end
  
    describe "DELETE /tasks/:id" do
      it "should return 200 for a valid task" do
        on_schema account.subdomain do
          task.save
        end

        delete "/tasks/#{task.id}", format: :json
        expect(last_response.status).to eq(200)
      end

      it "should return 404 for a non existant task" do
        delete "/tasks/1337", format: :json
        expect(last_response.status).to eq(404)
      end
    end

    describe "PUT /tasks/:id" do
      it "should return 200 for an existant task" do
        on_schema account.subdomain do
          task.save
        end

        put "/tasks/#{task.id}", task: attributes_for(:task, title: 'EDITED'), format: :json
        expect(last_response.status).to eq(200)
      end

      it "should return 422 with invalid attributes" do
        on_schema account.subdomain do
          task.save
        end

        put "/tasks/#{task.id}", task: attributes_for(:task, title: ''), format: :json
        expect(last_response.status).to eq(422)
      end

      it "should return 404 for a non existant task" do
        put "/tasks/1337", task: attributes_for(:task, title: 'EDITED'), format: :json
        expect(last_response.status).to eq(404)
      end
    end

    describe "GET /tasks/:id" do
      it "should return 200 for an existant task" do
        on_schema account.subdomain do
          task.save
        end

        get "/tasks/#{task.id}", format: :json
        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)['title']).to eq('Task Title')
      end

      it "should return 404 for non existant task" do
        get "/tasks/1337", format: :json
        expect(last_response.status).to eq(404)
      end
    end
  end

  context "using project as taskable resource" do
    let!(:project) { create_on_schema :project, account.subdomain }

    describe "GET /projects/:project_id/tasks" do
      it "should return 200 and empty tasks" do
        get "/projects/#{project.id}/tasks", format: :json
        expect(last_response.status).to eq(200)
        expect(JSON::parse(last_response.body)["tasks"].count).to eq(0)
      end

      it "should return 200 and one task" do
        on_schema account.subdomain do
          task = build(:task)
          task.taskable = project
          task.assigned = user
          task.reporter = user
          task.save!
        end

        get "/projects/#{project.id}/tasks", format: :json

        expect(last_response.status).to eq(200)
        expect(JSON::parse(last_response.body)["tasks"].count).to eq(1)
      end

      it "should return 404 for non existant project" do
        get '/projects/1337/tasks', format: :json
        expect(last_response.status).to eq(404)
      end
    end

    describe "POST /projects/:project_id/tasks" do
      it "should save task with valid attributes" do
        post "/projects/#{project.id}/tasks", task: attributes_for(:task, assigned_id: user.id, reporter_id: user.id), format: :json

        expect(last_response.status).to eq(201)
        on_schema account.subdomain do
          expect(Project.find(project.id).tasks.count).to eq(1)
        end
      end

      it "should return 404 for non existant project" do
        post "/projects/1337/tasks", task: attributes_for(:task, assigned_id: user.id, reporter_id: user.id), format: :json
        expect(last_response.status).to eq(404)
      end

      it "should return 422 for invalid task attributes" do
        post "/projects/#{project.id}/tasks", task: attributes_for(:task), format: :json
        expect(last_response.status).to eq(422)
      end
    end
  end

  context "using user for retrieve tasks" do
    let!(:project) { create_on_schema :project, account.subdomain }
    let!(:task) { build(:task, taskable: project, assigned: user, reporter: user) }

    describe "GET /users/:user_id/tasks" do
      it "should return 200 and empty tasks" do
        get "/users/#{user.id}/tasks", format: :json
        expect(last_response.status).to eq(200)
        expect(JSON::parse(last_response.body)["tasks"].count).to eq(0)
      end

      it "should return 200 and one task" do
        on_schema account.subdomain do
          task = build(:task)
          task.taskable = project
          task.assigned = user
          task.reporter = user
          task.save!
        end

        get "/users/#{user.id}/tasks", format: :json

        expect(last_response.status).to eq(200)
        expect(JSON::parse(last_response.body)["tasks"].count).to eq(1)
      end

      it "should return 404 for non existant user" do
        get '/users/1337/tasks', format: :json
        expect(last_response.status).to eq(404)
      end
    end
  end
end