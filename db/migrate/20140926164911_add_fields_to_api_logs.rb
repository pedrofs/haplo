class AddFieldsToApiLogs < ActiveRecord::Migration
  def change
    add_column :api_logs, :response_status, :integer
    add_column :api_logs, :response_body, :text
    add_column :api_logs, :requested_at, :timestamp
  end
end
