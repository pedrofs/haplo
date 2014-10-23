require 'spec_helper'

describe User do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end

  describe "associations" do
    it { should belong_to :role }
  end
end