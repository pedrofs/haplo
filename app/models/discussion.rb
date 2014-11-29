class Discussion < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :targets

  validates :user, presence: true
  validates :content, presence: true
 
  scope :load_associations, -> {
    includes(:user)
    .includes(comments: :user)
    .joins(:targets)
    .group('discussions.id')
  }

  scope :for_target, -> (targetable_id, targetable_type) {
    where(targets: { targetable_id: targetable_id, targetable_type: targetable_type })
  }

  scope :for_user, -> (user_id) {
    where(discussions: {user_id: user_id})
  }

  def build_targets_from_targetable targetable
    target = targetable.targets.build
    targets.concat target
    build_targets_from_targetable targetable.parent_targetable unless targetable.parent_targetable.nil?
  end

  def to_builder
    Jbuilder.new do |discussion|
      discussion.id id
      discussion.content content
      discussion.user user, :name, :email
      discussion.created_at created_at
      discussion.updated_at updated_at
    end
  end
end
