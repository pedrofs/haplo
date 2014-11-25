class AddTargetableFieldsToTarget < ActiveRecord::Migration
  def change
    add_column :targets, :targetable_id, :integer
    add_column :targets, :targetable_type, :string
  end
end
