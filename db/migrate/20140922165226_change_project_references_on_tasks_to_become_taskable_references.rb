class ChangeProjectReferencesOnTasksToBecomeTaskableReferences < ActiveRecord::Migration
  def change
    remove_column :tasks, :project_id
    add_column :tasks, :taskable_id, :integer
    add_column :tasks, :taskable_type, :string
  end
end
