class CreateFavoriteProjects < ActiveRecord::Migration
  def change
    create_table :favorite_projects do |t|
      t.references :user, index: true
      t.references :project, index: true

      t.timestamps
    end
  end
end
