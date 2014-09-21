class AddExtraFieldsToApiLog < ActiveRecord::Migration
  def change
    add_column :api_logs, :request_method, :string
  end
end
