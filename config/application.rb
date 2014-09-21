require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

require 'apartment/elevators/subdomain'

module TitleLess
  class Application < Rails::Application
    config.middleware.use 'Apartment::Elevators::MySubdomain'
    config.middleware.use 'ApiRequestLog'
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

class ApiRequestLog
  BASE_DIR = 'log/api'

  def initialize app
    @app = app
  end

  def call(env)
    request = Rack::Request.new env

    log env, request unless request.path.match /^\/assets/
    
    @app.call env
  end

  private

  def log env, request
    params = request.params
    controller_and_action = Rails.application.routes.recognize_path request.url, method: request.request_method

    api_log_file = ApiFileLog.new File.join(ApiRequestLog::BASE_DIR, Rails.env, Apartment::Tenant.current_tenant)

    api_log = ApiLog.new controller: params[:controller],
                       action: params[:action],
                       ip_address: request.ip,
                       url: request.url,
                       path: request.path,
                       params: env['rack.input'].read,
                       request_method: request.request_method,
                       user_id: user_id_for_request(env),
                       controller: controller_and_action[:controller],
                       action: controller_and_action[:action]

    api_log_file.log api_log if api_log.valid?
  end

  private

  def user_id_for_request env
    return unless token = env['HTTP_X_USER_TOKEN']

    User.find_by(authentication_token: token).try(:id)
  end
end
