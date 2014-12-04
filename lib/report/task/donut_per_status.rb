module Report
  module Task
    class DonutPerStatus
      def data *args
        project_id = args.first

        data = []

        per_status = ::Task.where(taskable_id: project_id, taskable_type: 'Project').all.group_by {|t| t.status}

        ::Task::STATUSES.each_with_index do |s, i|
          count = per_status[i].try(:count) || 0
          data << [s, count]
        end

        data
      rescue NameError
        []
      end
    end
  end
end