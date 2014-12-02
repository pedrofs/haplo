class Timelog < ActiveRecord::Base
  class TaskAlreadyStarted < ::StandardError
  end

  class TaskNotStarted < ::StandardError
  end

  belongs_to :task
  belongs_to :user
  has_one :project, through: :task

  validates :started_at, presence: true, on: :create
  validates :user, presence: true
  validates :task, presence: true

  class << self
    def start! task, user
      raise TaskAlreadyStarted, 'A tarefa já está sendo feita por você.' if timelog_for task, user

      timelog = self.new
      timelog.task = task
      timelog.started_at = Time.now
      timelog.user = user
      timelog.save!
      timelog
    end

    def stop! task, user
      timelog = timelog_for task, user
      raise TaskNotStarted, 'A tarefa não foi iniciado por você ainda.' if timelog.nil?

      timelog.stopped_at = Time.now
      timelog.save!
      timelog
    end

    def timelog_for task, user
      find_by(task_id: task.id, user_id: user.id, stopped_at: nil)
    end
  end

  def to_builder
    Jbuilder.new do |timelog|
      timelog.id id
      timelog.started_at started_at
      timelog.stopped_at stopped_at
      timelog.content content
      timelog.user user.to_builder
      timelog.task task.to_builder
    end
  end
end
