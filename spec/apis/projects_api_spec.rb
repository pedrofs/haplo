require 'spec_helper'

describe "Projects API", type: :api do
  let(:user) { build(:logged_user) }
  let!(:account) { create(:account_with_schema, subdomain: ApiHelper::SUBDOMAIN, owner: user) }

  context "authenticated" do
    before :each do
      set_header user
    end

    after :each do
      set_header nil
    end

    describe "GET /projects" do
      it "should return 200" do
        get '/projects', format: :json

        expect(last_response.status).to eq(200)
      end
    end

    describe "GET /project" do
      it "should return 200 for a valid project" do
        project = create_on_schema :project, account.subdomain

        get "/projects/#{project.id}", format: :json

        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)).to satisfy {|v| v.has_key? "name" }
      end

      it "should return 404 a nonexistent project" do
        get "/projects/404", format: :json

        expect(last_response.status).to eq(404)
      end
    end

    describe "POST /projects" do
      it "should return 201 with valid attributes and without phases" do
        post '/projects', project: attributes_for(:project), format: :json

        expect(last_response.status).to eq(201)
      end

      it "should return 422 with invalid attributes" do
        post '/projects', project: attributes_for(:project, name: nil), format: :json

        expect(last_response.status).to eq(422)
        expect(JSON.parse(last_response.body)).to satisfy {|v| v.has_key? "errors" }
      end

      context "with project phases" do
        let(:phases_attributes) { [attributes_for(:project_phase)] }

        it "should return 201 with valid attributes" do
          project = { project: attributes_for(:project).merge({project_phases_attributes: phases_attributes}) }

          post '/projects', project.merge({format: :json})

          expect(last_response.status).to eq(201)
        end

        it "should return 422 with invalid attributes" do
          phases_attributes << attributes_for(:invalid_project_phase)

          project = { project: attributes_for(:project).merge({project_phases_attributes: phases_attributes}) }

          post '/projects', project.merge({format: :json})

          expect(last_response.status).to eq(422)
          expect(JSON::parse(last_response.body)).to satisfy {|v| v.has_key? "errors" }
        end

        it "should not create project phases that are marked for destroy" do
          phases_attributes << attributes_for(:project_phase, _destroy: 1)

          project = { project: attributes_for(:project).merge({project_phases_attributes: phases_attributes}) }

          post '/projects', project.merge({format: :json})

          expect(last_response.status).to eq(201)

          on_schema account.subdomain do
            expect(ProjectPhase.all.count).to eq(1)
          end
        end
      end
    end

    describe "PUT /projects" do
      it "should return 204 with valid attributes" do
        project = create_on_schema :project, account.subdomain

        put "/projects/#{project.id}", project: attributes_for(:project, name: 'Edited'), format: :json

        expect(last_response.status).to eq(204)
      end

      it "should return 422 with invalid attributes" do
        project = create_on_schema :project, account.subdomain

        put "/projects/#{project.id}", project: attributes_for(:project, name: nil), format: :json

        expect(last_response.status).to eq(422)
        expect(JSON.parse(last_response.body)).to satisfy {|v| v.has_key? "errors" }
      end

      it "should return 404 for not found entity" do
        put "/projects/404", project: attributes_for(:project, name: 'Edited'), format: :json

        expect(last_response.status).to eq(404)
      end
    end

    describe "DELETE /projects" do
      it "should return 204 for a valid project" do
        project = create_on_schema :project, account.subdomain

        delete "/projects/#{project.id}", format: :json

        expect(last_response.status).to eq(204)
      end

      it "should return 404 for a nonexistent project" do
        delete "/projects/404", format: :json

        expect(last_response.status).to eq(404)
      end
    end
  end

  context "not authenticated" do
      describe "GET /projects" do
        it "should return 401" do
          get '/projects', format: :json

          expect(last_response.status).to eq(401)
        end
      end

      describe "POST /projects" do
        it "should return 401" do
          post '/projects', project: attributes_for(:project), format: :json

          expect(last_response.status).to eq(401)
        end
      end

      describe "PUT /projects" do
        it "should return 401" do
          put '/projects/4', project: attributes_for(:project), format: :json

          expect(last_response.status).to eq(401)
        end
      end

      describe "DELETE /destroy" do
        it "should return 401" do
          delete '/projects/4', format: :json

          expect(last_response.status).to eq(401)
        end
      end
  end
end