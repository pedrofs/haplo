Apartment.configure do |config|
  config.excluded_models = ['Account']
end

Apartment::Elevators::Subdomain.excluded_subdomains = ['www']