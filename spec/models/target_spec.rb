require 'spec_helper'

describe Target do
  describe 'validations' do
    it { should validate_presence_of :targetable }
    it { should validate_presence_of :discussion }
  end

  describe 'associations' do
    it { should belong_to :discussion }
    it { should belong_to :targetable }
  end
end