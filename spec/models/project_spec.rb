require 'spec_helper'

describe Project do
  it_behaves_like "Targetable"

  describe "validation" do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
    it { should validate_presence_of :client }
  end

  describe "associations" do
    it { should have_many :tasks }
    it { should have_many :favorite_projects }
  end

  it "defaults archived to false" do
    expect(Project.new).to_not be_archived
  end
end
