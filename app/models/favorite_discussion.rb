class FavoriteDiscussion < ActiveRecord::Base
  belongs_to :user
  belongs_to :discussion

  validates_presence_of :user_id, :discussion_id

  def self.toggle_discussion_for_user discussion, user
    favorite_discussion = current_favorite_discussion_for_user(discussion, user)

    return favorite_discussion.destroy if favorite_discussion

    create user_id: user.id, discussion_id: discussion.id
  end

  private

  def self.current_favorite_discussion_for_user discussion, user
    find_by discussion_id: discussion.id, user_id: user.id
  end
end
