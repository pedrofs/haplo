require 'csv'

class ApiLog < ActiveRecord::Base
  validates :ip_address, presence: true
  validates :controller, presence: true
  validates :action, presence: true
  validates :url, presence: true
  validates :path, presence: true
  validates :request_method, presence: true

  def to_csv
    csv_hash.values.to_csv.force_encoding('iso8859-1').encode('UTF-8')
  end

  def csv_header
    csv_hash.keys.to_csv
  end

  private

  def csv_hash
    {
      requested_at: requested_at,
      ip_address: ip_address,
      request_method: request_method,
      controller: controller,
      action: action,
      url: url,
      path: path,
      params: params,
      user_id: user_id,
      response_status: response_status,
      response_body: response_body
    }
  end
end
