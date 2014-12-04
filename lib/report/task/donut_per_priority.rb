module Report
  module Task
    class DonutPerPriority
      def data *args
        project_id = args.first

        data = []

        per_priority = ::Task.where(taskable_id: project_id, taskable_type: 'Project', status: 0).all.group_by {|t| t.priority}

        ::Task::PRIORITIES.each_with_index do |p, i|
          count = per_priority[i].try(:count) || 0
          data << [p, count]
        end

        data
      rescue NameError
        []
      end
    end
  end
end