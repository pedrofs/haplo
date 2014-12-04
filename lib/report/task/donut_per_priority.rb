module Report
  module Task
    class DonutPerPriority
      def data *args
        project_id = args.first

        data = [[]]

        per_priority_count = ::Task.where(taskable_id: project_id, taskable_type: 'Project').group(:priority).count

        per_priority_count.each do |priority, count|
          priority ||= 0
          data.first << [::Task::PRIORITIES[priority], count]
        end

        data
      rescue NameError
        []
      end
    end
  end
end