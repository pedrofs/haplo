module ApiHelper
  include Rack::Test::Methods

  HOST = 'example.org'
  SUBDOMAIN = 'subdomain4test1337'

  def app
    Rails.application
  end

  def build_rack_mock_session
    Rack::MockSession.new(app, default_host)
  end

  private

  def default_host
    "#{ApiHelper::SUBDOMAIN}.#{ApiHelper::HOST}"
  end
end

RSpec.configure do |config|
  config.include ApiHelper, type: :api
end