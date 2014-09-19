class CreateProjectPhases < ActiveRecord::Migration
  def change
    create_table :project_phases do |t|
      t.string :name
      t.string :description
      t.references :project, index: true
      t.date :start_at
      t.date :end_at

      t.timestamps
    end
  end
end
