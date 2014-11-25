class Target < ActiveRecord::Base
  belongs_to :discussion
  belongs_to :targetable, polymorphic: true

  validates :discussion, presence: true
  validates :targetable, presence: true
end
