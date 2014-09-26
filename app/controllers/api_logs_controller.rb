class ApiLogsController < ApplicationController
  include ActionController::Live

  def index
    response.headers['Content-Type'] = 'text/event-stream'
    sse = SSE.new(response.stream)

    api_log_import = ApiLogImport.new log_filename

    api_logs = api_log_import.build_api_logs do |builded_api_logs|
      sse.write({count: builded_api_logs.count}, event: 'counting')
    end

    api_log_import.remove_log

    api_logs.each_with_index do |a, i|
      sse.write({progress: i}, event: 'progress') if a.save
    end
  ensure
    sse.write({api_logs: ApiLog.paginate(page: params[:page] || 1).order('created_at DESC')}, event: 'complete')
    sse.close
  end

  private

  def log_filename
    File.join(ApiRequestLog::BASE_DIR, Rails.env, Apartment::Tenant.current_tenant, ApiFileLog::FILENAME)
  end
end