class Project < ActiveRecord::Base
  has_many :project_phases, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :client, presence: true

  accepts_nested_attributes_for :project_phases, allow_destroy: true
end
