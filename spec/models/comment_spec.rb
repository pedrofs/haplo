require 'spec_helper'

describe Comment do
  describe 'validations' do
    it { should validate_presence_of :user }
    it { should validate_presence_of :content }
  end

  describe 'associations' do
    it { should belong_to :user }
    it { should belong_to :discussion }
  end
end