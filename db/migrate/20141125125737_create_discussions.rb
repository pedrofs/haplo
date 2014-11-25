class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.references :user, index: true
      t.text :content

      t.timestamps
    end
  end
end
