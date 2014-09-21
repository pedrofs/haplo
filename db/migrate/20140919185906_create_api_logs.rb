class CreateApiLogs < ActiveRecord::Migration
  def change
    create_table :api_logs do |t|
      t.string :controller
      t.string :action
      t.string :ip_address
      t.string :path
      t.string :url
      t.string :params
      t.references :user, index: true

      t.timestamps
    end
  end
end
