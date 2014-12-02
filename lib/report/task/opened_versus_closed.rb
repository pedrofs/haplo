module Report
  module Task
    class OpenedVersusClosed
      def data *args
        opened_data = []
        closed_data = []
        opened = ::Task.all.group_by {|task| task.created_at && task.created_at.strftime("%Y-%m-%d")}
        closed = ::Task.all.group_by {|task| task.closed_at && task.closed_at.strftime("%Y-%m-%d")}

        labels = (1.week.ago.to_date..Date.today).map { |d| d.strftime("%Y-%m-%d") }

        labels.each do |label|
          opened_data << [label, opened[label].try(:count) || 0]
          closed_data << [label, closed[label].try(:count) || 0]
        end

        [opened_data, closed_data]
      end
    end
  end
end