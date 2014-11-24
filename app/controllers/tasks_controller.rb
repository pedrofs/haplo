class TasksController < ApplicationController
  def index
    params_id = params[:project_id] || params[:user_id]
    klass = (params[:project_id] && Project) || (params[:user_id] && User)

    resource = klass.find_by_id! params_id

    @tasks = resource.tasks
    @paginated_tasks = @tasks.paginate(page: params[:page] || 1)
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  def show
    @task = Task.find_by! id: params[:id]

    render json: @task.to_builder.attributes!
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  def create
    project = Project.find_by_id! params[:project_id]
    @task = Task.new task_params
    @task.taskable = project
    @task.reporter = current_user

    @task.save!

    render json: {task: @task.to_builder.attributes!, flash: 'Tarefa criada com sucesso.', status: 'success'}, status: :created
  rescue  ActiveRecord::RecordInvalid
    render_errors @task
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  def update
    @task = Task.find_by! id: params[:id]

    @task.update_attributes! task_params

    render json: {task: @task.to_builder.attributes!, flash: 'Tarefa atualizada com sucesso.', status: 'success'}, status: :ok
  rescue ActiveRecord::RecordNotFound
    render_not_found
  rescue ActiveRecord::RecordInvalid
    render_errors @task
  end

  def destroy
    @task = Task.find_by! id: params[:id]

    @task.destroy!

    render json: {flash: 'Tarefa excluída com sucesso.', type: 'success'}, status: :ok
  rescue ActiveRecord::RecordNotDestroyed
    render json: {flash: 'Não foi possível deletar a tarefa.', type: 'danger'}, status: :bad_request
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :estimated_time, :time_spent, :progress, :assigned_id, :reporter_id)
  end
end