class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def create
    @project = Project.new project_params

    respond_with @project.save!

  rescue ActiveRecord::InvalidRecord
    render_errors @project
  end

  def destroy
    @project = Project.find_by! id: params[:id]

    respond_with @project.destroy!

    rescue ActiveRecord::RecordNotDestroyed
      render json: {flash: 'Não foi possível deletar o projeto.'}, status: :bad_request
    rescue ActiveRecord::RecordNotFound
      render_not_found
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :client, :archived)
  end
end