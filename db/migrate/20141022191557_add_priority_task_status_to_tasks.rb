class AddPriorityTaskStatusToTasks < ActiveRecord::Migration
  def change
    change_table :tasks do |t|
      t.references :task_status
      t.integer :priority
    end
  end
end
