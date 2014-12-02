class CreateTimelogs < ActiveRecord::Migration
  def change
    create_table :timelogs do |t|
      t.timestamp :started_at
      t.timestamp :stopped_at
      t.text :content
      t.references :task, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
