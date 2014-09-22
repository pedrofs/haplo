require 'csv'

class ApiLog < ActiveRecord::Base
  validates :ip_address, presence: true
  validates :controller, presence: true
  validates :action, presence: true
  validates :url, presence: true
  validates :path, presence: true
  validates :request_method, presence: true

  def to_csv
    csv_hash.values.to_csv
  end

  def csv_header
    csv_hash.keys.to_csv
  end

  private

  def csv_hash
    {
      created_at: created_at,
      ip_address: ip_address,
      request_method: request_method,
      controller: controller,
      action: action,
      url: url,
      path: path,
      params: params,
      user_id: user_id
    }
  end
end
