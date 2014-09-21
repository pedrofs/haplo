class ApiLog < ActiveRecord::Base
  validates :ip_address, presence: true
  validates :controller, presence: true
  validates :action, presence: true
  validates :url, presence: true
  validates :path, presence: true
  validates :request_method, presence: true

  def to_csv
    [created_at,
     ip_address,
     request_method,
     controller,
     action,
     url,
     path,
     params,
     user_id].join ','
  end
end
