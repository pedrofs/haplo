module Report
  module Task
    class DonutPerStatus
      def data *args
        data = [[]]

        per_status_count = ::Task.all.group(:status).count

        per_status_count.each do |status, count|
          data.first << [::Task::STATUSES[status], count]
        end

        data
      rescue NameError
        []
      end
    end
  end
end