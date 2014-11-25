require 'spec_helper'

describe Discussion do
  describe 'validations' do
    it { should validate_presence_of :user }
    it { should validate_presence_of :content }
  end

  describe 'associations' do
    it { should belong_to :user }
    it { should have_many :targets }
    it { should have_many :comments }
  end

  describe "create discussion with its targets" do
    it "should build one target when building from a project" do
      project = create :project
      discussion = build :discussion
      discussion.build_targets_from_targetable project
      expect(discussion.targets.first.targetable_id).to be(project.id)
      expect(discussion.targets.size).to eq(1)
      expect { discussion.save! }.to change { Target.all.count }.to(1).from(0)
    end

    it "should build TWO targets when building from a task" do
      task = create :task_with_users_and_project
      discussion = build :discussion
      discussion.build_targets_from_targetable task
      expect(discussion.targets.size).to eq(2)
      expect { discussion.save! }.to change { Target.all.count }.to(2).from(0)
    end

    it "should build THREE targets when building from a TIMELOG" do
    end
  end
end