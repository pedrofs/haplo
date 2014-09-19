require 'spec_helper'

describe ProjectPhase do
  describe "validation" do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of(:name).scoped_to(:project_id) }
    it { should validate_presence_of :start_at }

    it "should not accept start_at greater than end_at" do
      expect { create(:invalid_project_phase) }.to raise_error
    end
  end

  describe "associations" do
    it { should belong_to :project }
  end

  describe "accepts nested attributes for project_phases" do
    it { expect { create(:project, project_phases_attributes: [attributes_for(:project_phase)]) }.to change(ProjectPhase, :count).by(1) }
  end

  it "defaults archived to false" do
    expect(Project.new).to_not be_archived
  end
end
