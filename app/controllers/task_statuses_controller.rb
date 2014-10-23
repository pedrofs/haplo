class TaskStatusesController < ApplicationController
  def index
    @statuses = TaskStatus.all
    respond_with @statuses
  end

  def show
    @status = TaskStatus.find_by id: params[:id]

    respond_with @status
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  def create
    @status = TaskStatus.new status_params

    @status.save!

    render json: @status, status: :created
  rescue ActiveRecord::RecordInvalid
    render_errors @status
  end

  def update
    @status = TaskStatus.find_by! id: params[:id]

    @status.update_attributes! status_params

    render json: @status, status: :ok
  rescue ActiveRecord::RecordInvalid
    render_errors @status
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  def destroy
    @task_status = TaskStatus.find_by! id: params[:id]

    respond_with @task_status.destroy!

    rescue ActiveRecord::RecordNotDestroyed
      render json: {flash: 'Não foi possível deletar o status.'}, status: :bad_request
    rescue ActiveRecord::RecordNotFound
      render_not_found
  end

  private

  def status_params
    params.require(:task_status).permit(:name)
  end
end