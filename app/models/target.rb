class Target < ActiveRecord::Base
  belongs_to :discussion
  belongs_to :targetable, polymorphic: true

  validates :discussion, presence: true
  validates :targetable, presence: true

  after_destroy :remove_discussion, if: -> { discussion.targets.count == 0 }

  private

  def remove_discussion
    discussion.destroy!
  end
end
