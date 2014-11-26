class Discussion < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :targets

  validates :user, presence: true
  validates :content, presence: true

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
