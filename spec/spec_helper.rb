ENV["RAILS_ENV"] |= "test"

require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "rspec/autorun"
require "database_cleaner"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.check_pending if define?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Method
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
  end
end
