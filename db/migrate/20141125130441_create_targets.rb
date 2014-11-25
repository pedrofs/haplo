class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.references :discussion, index: true

      t.timestamps
    end
  end
end
