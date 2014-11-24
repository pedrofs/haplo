class TaskStatusesController < ApplicationController
  def index
    render json: Task::STATUSES
  end
end