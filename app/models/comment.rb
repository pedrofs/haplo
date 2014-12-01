class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :discussion

  validates :user, presence: true
  validates :content, presence: true
  validates :discussion, presence: true

  def to_builder
    Jbuilder.new do |comment|
      comment.id id
      comment.content content
      comment.created_at created_at
      comment.updated_at updated_at
      comment.user do
        comment.id user.id
        comment.name user.name
        comment.image do
          comment.small user.image :small
          comment.medium user.image :medium
          comment.big user.image :big
        end
      end
    end
  end
end
