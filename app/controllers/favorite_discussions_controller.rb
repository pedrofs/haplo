class FavoriteDiscussionsController < ApplicationController
  respond_to :json

  def index
    user_id = params[:user_id] || current_user

    @favorite_discussions = FavoriteDiscussion.eager_load(:discussion).where(user_id: user_id).all
  end

  def toggle
    discussion = Discussion.find_by! id: params[:discussion_id]

    favorite_discussion = FavoriteDiscussion.toggle_discussion_for_user discussion, current_user

    if favorite_discussion.destroyed?
      render json: {}, status: :no_content
    else
      render json: favorite_discussion, status: :created
    end
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end
end