class CreateFavoriteDiscussions < ActiveRecord::Migration
  def change
    create_table :favorite_discussions do |t|
      t.references :discussion, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
