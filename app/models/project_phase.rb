class ProjectPhase < ActiveRecord::Base
  belongs_to :project

  validates :name, presence: true, uniqueness: { scope: :project_id }
  validates :start_at, presence: true

  validate :start_at_cannot_be_greater_than_end_at

  protected

  def start_at_cannot_be_greater_than_end_at
    errors.add(:start_at, "tem que ser antes da data de fim") if end_at && start_at >= end_at
  end
end
