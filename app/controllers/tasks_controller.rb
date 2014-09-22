class TasksController < ApplicationController
  def index
    params_id = params[:project_id] || params[:user_id]
    klass = (params[:project_id] && Project) || (params[:user_id] && User)

    resource = klass.find_by_id! params_id

    respond_with resource.tasks
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  def show
    @task = Task.find_by! id: params[:id]

    respond_with @task
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  def create
    project = Project.find_by_id! params[:project_id]
    @task = Task.new task_params
    @task.taskable = project

    @task.save!

    respond_with @task, location: nil, code: :created
  rescue  ActiveRecord::RecordInvalid
    render_errors @task
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  def update
    @task = Task.find_by! id: params[:id]

    @task.update_attributes! task_params

    respond_with @task
  rescue ActiveRecord::RecordNotFound
    render_not_found
  rescue ActiveRecord::RecordInvalid
    render_errors @task
  end

  def destroy
    @task = Task.find_by! id: params[:id]

    respond_with @task.destroy!
  rescue ActiveRecord::RecordNotDestroyed
    render json: {flash: 'Não foi possível deletar a tarefa.'}, code: :bad_request
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :estimated_time, :time_spent, :progress, :assigned_id, :reporter_id)
  end
end