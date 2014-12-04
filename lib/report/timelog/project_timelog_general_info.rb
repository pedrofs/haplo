module Report
  module Timelog
    class ProjectTimelogGeneralInfo
      def data *args
        project_id = args.first

        project = ::Project.find_by! id: project_id
        timelogs = project.timelogs.where('stopped_at IS NOT NULL')

        count = timelogs.count

        total_time = 0
        total_time = timelogs.collect { |t| t.stopped_at - t.started_at }.inject(:+)

        total_tasks = timelogs.group_by {|t| t.task_id}.count

        [total_tasks, count, total_time]
      end
    end
  end
end