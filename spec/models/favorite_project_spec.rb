require 'spec_helper'

describe FavoriteProject do
  describe 'validations' do
    it { should validate_presence_of :project_id }
    it { should validate_presence_of :user_id }
  end

  describe 'associations' do
    it { should belong_to :user }
    it { should belong_to :project }
  end

  it "should toggle favorite project on" do
    project = double('project')
    user = double('user')
    allow(project).to receive(:id).and_return 1
    allow(user).to receive(:id).and_return 1

    expect {
      FavoriteProject.toggle_project_for_user project, user
    }.to change { FavoriteProject.all.count }.from(0).to(1)
  end

  it "should toggle favorite project off" do
    favorite_project = create(:favorite_project, user_id: 1, project_id: 1)
    project = double('project')
    user = double('user')
    allow(project).to receive(:id).and_return 1
    allow(user).to receive(:id).and_return 1

    expect {
      destroyed_favorite_project = FavoriteProject.toggle_project_for_user(project, user)
      expect(destroyed_favorite_project.destroyed?).to be(true)
    }.to change { FavoriteProject.all.count }.from(1).to(0)
  end
end