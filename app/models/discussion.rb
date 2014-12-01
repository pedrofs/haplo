class Discussion < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :targets
  has_many :favorite_discussions, dependent: :destroy

  validates :user, presence: true
  validates :title, presence: true, uniqueness: true
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

  after_destroy :remove_targets

  def build_targets_from_targetable targetable
    target = targetable.targets.build
    targets.concat target
    build_targets_from_targetable targetable.parent_targetable unless targetable.parent_targetable.nil?
  end

  def to_builder
    Jbuilder.new do |discussion|
      discussion.id id
      discussion.title title
      discussion.content content
      discussion.comments_count comments.count

      discussion.comments comments do |comment|
        comment.to_builder
      end

      discussion.user do
        discussion.id user.id
        discussion.name user.name
        discussion.image do
          discussion.small user.image(:small)
          discussion.medium user.image(:medium)
          discussion.big user.image(:big)
        end
      end

      discussion.targets targets do |target|
        discussion.id target.targetable.id
        discussion.label target.targetable.label
        discussion.type target.targetable_type
      end

      discussion.created_at created_at
      discussion.updated_at updated_at
    end
  end

  private

  def remove_targets
    targets.each &:delete
  end
end
