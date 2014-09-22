class Task < ActiveRecord::Base
  belongs_to :assigned, class: User
  belongs_to :reporter, class: User
  belongs_to :taskable, polymorphic: true

  validates :title, presence: true, uniqueness: true
  validates :assigned, presence: true
  validates :reporter, presence: true
  validates :taskable, presence: true
end
