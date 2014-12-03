class AddTodayColumnToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :today, :boolean
  end
end
