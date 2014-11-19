class Task < ActiveRecord::Base
  belongs_to :assigned, class: User
  belongs_to :reporter, class: User
  belongs_to :taskable, polymorphic: true
  belongs_to :task_status

  validates :title, presence: true, uniqueness: true
  validates :assigned, presence: true
  validates :reporter, presence: true
  validates :taskable, presence: true
  validates :task_status_id, presence: true

  def to_builder
    Jbuilder.new do |task|
      task.id id
      task.title title
      task.assigned assigned, :name, :email
      task.status task_status, :name
      task.progress progress
      task.created_at created_at
    end
  end
end
