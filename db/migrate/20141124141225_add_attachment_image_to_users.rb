class AddAttachmentImageToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :projects, :image
  end
end
