require 'spec_helper'

describe Project do
  describe "validation" do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
    it { should validate_presence_of :client }
  end

  describe "associations" do
    it { should have_many :project_phases }
    it { should have_many :tasks }
  end

  describe "accepts nested attributes for project_phases" do
    it { expect { create(:project, project_phases_attributes: [attributes_for(:project_phase)]) }.to change(ProjectPhase, :count).by(1) }

    it { expect { create(:project, project_phases_attributes: [attributes_for(:project_phase, _destroy: 1)]) }.to change(ProjectPhase, :count).by(0) }
  end

  describe ""

  it "defaults archived to false" do
    expect(Project.new).to_not be_archived
  end
end
