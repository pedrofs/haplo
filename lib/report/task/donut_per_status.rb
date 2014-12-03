module Report
  module Task
    class DonutPerStatus
      def data *args
        project_id = args.first
        data = [[]]

        per_status_count = ::Task.where(taskable_id: project_id, taskable_type: 'Project').group(:status).count

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