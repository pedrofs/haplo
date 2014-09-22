class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.float :estimated_time
      t.float :time_spent
      t.integer :progress
      t.references :assigned, index: true
      t.references :reporter, index: true
      t.references :project, index: true

      t.timestamps
    end
  end
end
