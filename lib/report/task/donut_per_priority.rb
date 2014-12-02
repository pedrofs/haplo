module Report
  module Task
    class DonutPerPriority
      def data *args
        data = [[]]

        per_priority_count = ::Task.all.group(:priority).count

        per_priority_count.each do |priority, count|
          data.first << [::Task::PRIORITIES[priority], count]
        end

        data
      rescue NameError
        []
      end
    end
  end
end