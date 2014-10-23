require 'spec_helper'

describe "Task Statuses API", type: :api do
  let(:user) { build(:logged_user) }
  let!(:account) { create(:account_with_schema, subdomain: ApiHelper::SUBDOMAIN, owner: user) }

  before :each do
    set_header user
  end

  
  describe "DELETE /task_statuses/:id" do
    it "should return 204 for a valid status" do
    end

    it "should return 404 for a non existant status" do
    end
  end

  describe "PUT /task_statuses/:id" do
    it "should return 200 for an existant status" do
    end

    it "should return 422 with invalid attributes" do
    end

    it "should return 404 for a non existant status" do
    end
  end

  describe "POST /task_statuses/:id" do
    it "should return 201 with valid attributes" do
    end

    it "should return 422 with invalid attributes" do
    end
  end

  describe "GET /task_statuses" do
    it "should return 200" do
    end
  end

  describe "GET /task_statuses/:id" do
    it "should return 200 for an existant status" do
    end

    it "should return 404 for non existant status" do
    end
  end
end