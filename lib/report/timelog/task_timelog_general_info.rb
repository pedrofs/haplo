module Report
  module Timelog
    class TaskTimelogGeneralInfo
      def data *args
        task_id = args.first

        timelogs = ::Timelog.eager_load(:user).where("task_id = ? AND stopped_at IS NOT NULL", task_id)

        count = timelogs.count

        total_time = 0
        total_time = timelogs.collect { |t| t.stopped_at - t.started_at }.inject(:+)

        total_users = timelogs.group_by {|t| t.user_id}.count

        [total_users, count, total_time]
      end
    end
  end
end