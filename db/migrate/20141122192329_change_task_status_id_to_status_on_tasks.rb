class ChangeTaskStatusIdToStatusOnTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :task_status_id
    add_column :tasks, :status, :integer
  end
end
