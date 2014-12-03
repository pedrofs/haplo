class TimelogsController < ApplicationController
  def index
    if params[:search] and project_id = params[:search].delete(:project_id)
      project = Project.find_by id: project_id
      @timelogs = project.try(:timelogs) || []
    else
      @timelogs = Timelog.search(params[:search]).result
    end
  end

  def toggle
    task = Task.find_by! id: params[:task_id]

    timelog = Timelog.start! task, current_user

    render json: timelog.to_builder.attributes!
  rescue ActiveRecord::RecordNotFound
    render_not_found
  rescue Timelog::TaskAlreadyStarted
    timelog = Timelog.stop! task, current_user
    render json: timelog.to_builder.attributes!
  end

  def create
    timelog = Timelog.new timelog_params
    timelog.user = current_user
    timelog.save!
    render json: { timelog: timelog.to_builder.attributes!, flash: 'Timelog criado com sucesso.', type: 'success' }, status: :created
  rescue ActiveRecord::RecordInvalid
    render_errors timelog
  end

  def update
    timelog = Timelog.find_by! id: params[:id]
    timelog.update_attributes! timelog_params
    render json: timelog.to_builder.attributes!
  rescue ActiveRecord::RecordNotFound
    render_not_found
  rescue ActiveRecord::RecordInvalid
    render_errors timelog
  end

  def destroy
    timelog = Timelog.find_by! id: params[:id]
    timelog.destroy!
    render json: timelog.to_builder.attributes!
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  private

  def timelog_params
    params.require(:timelog).permit(:started_at, :stopped_at, :content, :task_id)
  end
end