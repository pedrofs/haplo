require 'spec_helper'

describe Task do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :assigned }
    it { should validate_presence_of :reporter }
    it { should validate_presence_of :taskable }
    it { should validate_presence_of :task_status_id }
    it { should validate_uniqueness_of :title }
  end

  describe "associations" do
    it { should belong_to :assigned }
    it { should belong_to :reporter }
    it { should belong_to :taskable }
    it { should belong_to :task_status }
  end
end