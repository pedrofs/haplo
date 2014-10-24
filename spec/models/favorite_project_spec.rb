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
end