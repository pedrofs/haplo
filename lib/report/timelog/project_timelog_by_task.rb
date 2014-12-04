module Report
  module Timelog
    class ProjectTimelogByTask
      def data *args
        data = []
        project_id = args.first
        from_date = ::DateTime.now-1.week
        to_date = ::DateTime.now

        project = ::Project.find_by! id: project_id
        timelogs = project.timelogs.where('stopped_at BETWEEN ? AND ?', from_date, to_date)

        timelogs_by_task = timelogs.group_by { |t| t.task_id }

        timelogs_by_task.each do |id, timelogs|
          task_data = []
          timelogs_by_date_for_task = timelogs.group_by { |t| t.stopped_at.strftime('%d%m%y') }

          (from_date..to_date).each do |date|
            formatted_date = date.strftime('%d%m%y')

            data_for_date = [date.to_i*1000, 0]

            if timelogs_by_date_for_task.has_key? formatted_date
              summed_timelogs = sum_timelogs timelogs_by_date_for_task[formatted_date]
              p summed_timelogs
              data_for_date = [date.to_i*1000, summed_timelogs]
            end

            task_data << data_for_date
          end

          data << task_data
        end

        data
      rescue ActiveRecord::RecordNotFound
        []
      end

      private

      def sum_timelogs timelogs
        (timelogs.collect { |t| t.stopped_at - t.started_at }.inject(:+))/60/60
      end
    end
  end
end