class FavoriteProjectsController < ApplicationController
  def index
    user_id = params[:user_id]

    FavoriteProject
  end

  def toggle
    user_id = current_user.id
    favorite_project_params = { project_id: params[:project_id], user_id: user_id }

    Project.find_by! id: params[:project_id]

    if favorite_project = FavoriteProject.find_by(favorite_project_params)
      favorite_project.destroy
      render json: {}, status: :no_content
    else
      favorite_project = FavoriteProject.create! favorite_project_params

      render json: favorite_project, status: :created
    end
  rescue ActiveRecord::RecordNotFound
    render_not_found
  rescue ActiveRecord::RecordInvalid
    render_errors favorite_project
  end
end