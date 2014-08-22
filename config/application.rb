require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

require 'apartment/elevators/subdomain'

module TitleLess
  class Application < Rails::Application
    config.middleware.use 'Apartment::Elevators::MySubdomain'
  end
end

module Apartment
  module Elevators
    class MySubdomain < Apartment::Elevators::Subdomain
      DEFAULT_DATABASE = "public"
      EXCLUDED_DOMAINS = ['www']

      def call(env)
        request = Rack::Request.new(env)

        database = @processor.call(request)

        database = DEFAULT_DATABASE if Apartment::Elevators::Subdomain.excluded_subdomains.include? database

        begin
          Apartment::Tenant.switch database if database
        rescue Apartment::DatabaseNotFound, Apartment::SchemaNotFound
          return [404, {"Content-Type" => "json"}, ["Not Found"]]
        end

        @app.call(env)
      end
    end
  end
end
