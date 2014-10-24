class FavoriteProjectsController < ApplicationController
  respond_to :json

  def index
    user_id = params[:user_id]

    @favorite_projects = FavoriteProject.eager_load(:project).where(user_id: user_id).all
  end

  def toggle
    project = Project.find_by! id: params[:project_id]

    favorite_project = FavoriteProject.toggle_project_for_user project, current_user

    if favorite_project.destroyed?
      render json: {}, status: :no_content
    else
      render json: favorite_project, status: :created
    end
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end
end