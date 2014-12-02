class ChartsController < ApplicationController
  def index
    report = ::Report::ReportFactory.new.create params[:report_module], params[:report_name]
    data = report.data params[:report_params]

    render json: data
  end
end