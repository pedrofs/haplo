class TimelineController < ApplicationController
  def index
    respond_with current_user
  end
end