require 'spec_helper'

describe Timelog do
  describe 'validations' do
    it { should validate_presence_of :user }
    it { should validate_presence_of :task }
    it { should validate_presence_of :started_at }
  end

  describe 'associations' do
    it { should belong_to :user }
    it { should belong_to :task }
  end

  describe 'starting' do
    it 'should start a timelog for a task' do
      task = create(:task)
      timelog = Timelog.start! task, task.assigned
      expect(timelog.new_record?).to be(false)
      expect(timelog.started_at < Time.now).to be(true)
      expect(timelog.user).to be(task.assigned)
    end

    it 'should raise exception for starting a task twice' do
      task = create(:task)
      timelog = Timelog.start! task, task.assigned
      expect { Timelog.start! task, task.assigned }.to raise_error
    end
  end

  describe 'stopping' do
    it 'should stop a timelog for a task' do
      task = create(:task)
      timelog = Timelog.start! task, task.assigned
      timelog = Timelog.stop! task, task.assigned
      expect(timelog.valid?).to be(true)
      expect(timelog.stopped_at < Time.now).to be(true)
    end

    it 'should raise exception for stopping a task not started' do
      task = create(:task)
      expect { Timelog.stop! task, task.assigned }.to raise_error
    end

    it 'should raise exception for stopping a task twice' do
      task = create(:task)
      timelog = Timelog.start! task, task.assigned
      timelog = Timelog.stop! task, task.assigned
      expect { Timelog.stop! task, task.assigned }.to raise_error
    end
  end
end