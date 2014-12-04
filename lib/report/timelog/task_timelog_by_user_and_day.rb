module Report
  module Timelog
    class TaskTimelogByUserAndDay
      def data *args
        data = []
        task_id = args.first
        from_date = ::DateTime.now-1.week
        to_date = ::DateTime.now

        timelogs = ::Timelog.eager_load(:user).where("task_id = ? AND stopped_at BETWEEN ? AND ?", task_id, from_date, to_date)

        timelogs_by_user = timelogs.group_by { |t| t.user_id }

        timelogs_by_user.each do |id, timelogs|
          user_data = []
          timelogs_by_date_for_user = timelogs.group_by { |t| t.stopped_at.strftime('%d%m%y') }

          (from_date..to_date).each do |date|
            formatted_date = date.strftime('%d%m%y')

            data_for_date = [date.to_i*1000, 0]

            if timelogs_by_date_for_user.has_key? formatted_date
              summed_timelogs = sum_timelogs timelogs_by_date_for_user[formatted_date]
              data_for_date = [date.to_i*1000, summed_timelogs]
            end

            user_data << data_for_date
          end
          data << user_data
        end

        data
      end

      private

      def sum_timelogs timelogs
        (timelogs.collect { |t| t.stopped_at - t.started_at }.inject(:+))/60/60
      end
    end
  end
end