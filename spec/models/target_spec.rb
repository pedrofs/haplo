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

  describe 'when destroyed' do
    describe 'if it is the last target for its discussion' do
      it 'should destroy the discussion' do
        target = create :project_target
        target.destroy!
        expect(target.destroyed?).to be(true)
        expect(target.discussion.destroyed?).to be(true)
      end
    end

    describe 'if it isn\'t the last target for its discussion' do
      it 'should not destroy the discussion' do
        target = create :project_target
        target2 = create :task_target, discussion: target.discussion

        target.destroy!

        expect(target.destroyed?).to be(true)

        expect(target.discussion.destroyed?).to be(false)
      end
    end
  end
end