class ProjectsController < ApplicationController
  def index
    @projects = Project.all

    respond_with @projects
  end

  def show
    @project = Project.find_by! id: params[:id]

    render json: @project.to_builder.attributes!

  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  def create
    @project = Project.new project_params

    @project.save!

    render json: { project: @project.to_builder.attributes!, flash: 'Projeto criado com sucesso.', type: 'success' }, status: :created

  rescue ActiveRecord::RecordInvalid
    render_errors @project
  end

  def update
    @project = Project.find_by! id: params[:id]

    @project.update_attributes! project_params

    render json: { project: @project.to_builder.attributes!, flash: 'Projeto atualizado com sucesso.', type: 'success' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render_not_found
  rescue ActiveRecord::RecordInvalid
    render_errors @project
  end

  def destroy
    @project = Project.find_by! id: params[:id]

    @project.destroy!

    render json: {flash: 'Projeto deletado com sucesso.', type: 'success'}, status: :ok
  rescue ActiveRecord::RecordNotDestroyed
    render json: {flash: 'Não foi possível deletar o projeto.', type: 'danger'}, status: :bad_request
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  private

  def project_params
    params.require(:project).permit(:image,
                                    :name,
                                    :description,
                                    :client,
                                    :archived,
                                    project_phases_attributes: [:name, :start_at, :end_at, :_destroy])
  end
end