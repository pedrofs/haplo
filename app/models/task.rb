class Task < ActiveRecord::Base
  OPENED = 0
  RESOLVED = 1
  CLOSED = 2
  REOPENED = 3
  ARCHIVED = 4

  STATUSES = ['Aberta', 'Resolvida', 'Fechada', 'Reaberta', 'Arquivada']
  STATUSES_METHODS = [:close, :resolve, :reopen, :archive]

  PRIORITIES = ['Baixa', 'Média', 'Alta']

  include Targetable

  has_many :timelogs

  belongs_to :assigned, class: User
  belongs_to :reporter, class: User
  belongs_to :taskable, polymorphic: true
  belongs_to :task_status

  validates :title, presence: true, uniqueness: true
  validates :assigned, presence: true
  validates :reporter, presence: true
  validates :taskable, presence: true
  validates :status, presence: true

  before_validation :set_status_to_opened

  def to_builder
    Jbuilder.new do |task|
      task.id id
      task.title title
      task.description description
      task.assigned assigned, :name, :email
      task.status status
      task.status_name Task::STATUSES[status]
      task.today today || false
      task.project do
        task.id taskable.id
        task.name taskable.name
      end
      task.progress progress
      task.created_at created_at
    end
  end

  def resolve
    update_attribute :status, Task::RESOLVED
  end

  def close
    update_attribute :status, Task::CLOSED
  end

  def reopen
    update_attribute :status, Task::REOPENED
  end

  def archive
    update_attribute :status, Task::ARCHIVED
  end

  def parent_targetable
    taskable
  end

  def label
    title
  end

  protected

  def set_status_to_opened
    self[:status] = Task::OPENED
  end
end
