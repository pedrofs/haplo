ENV["RAILS_ENV"] ||= "test"

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'factory_girl_rails'
require 'database_cleaner'
require 'capybara/rspec'
require 'email_spec'
require 'rspec/mocks'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
Dir[Rails.root.join("spec/concerns/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

Capybara.app_host = 'http://example.com'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include EmailSpec::Matchers
  config.include EmailSpec::Helpers

  #config.include Devise::TestHelpers, type: :controller
  config.order = "random"

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
    Apartment::Tenant.reset
    drop_schemas
    Capybara.app_host = "http://example.com"
    reset_mailer
    FileUtils.rm_rf(Dir.glob(File.join(Rails.root, 'log/api/test/*')))
  end
end