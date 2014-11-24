class RemoveTaskStatuses < ActiveRecord::Migration
  def change
    drop_table :task_statuses
  end
end
