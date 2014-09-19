class ProjectsController < ApplicationController
  def index
    @projects = Project.all

    respond_with @projects
  end

  def show
    @project = Project.find_by! id: params[:id]

    respond_with @project

  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  def create
    @project = Project.new project_params

    @project.save!

    respond_with @project, code: :created

  rescue ActiveRecord::RecordInvalid
    render_errors @project
  end

  def update
    @project = Project.find_by! id: params[:id]

    @project.update_attributes! project_params

    respond_with @project
  rescue ActiveRecord::RecordNotFound
    render_not_found
  rescue ActiveRecord::RecordInvalid
    render_errors @project
  end

  def destroy
    @project = Project.find_by! id: params[:id]

    respond_with @project.destroy!

  rescue ActiveRecord::RecordNotDestroyed
    render json: {flash: 'Não foi possível deletar o projeto.'}, code: :bad_request
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :client, :archived, project_phases_attributes: [:name, :start_at, :end_at, :_destroy])
  end
end