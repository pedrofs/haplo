def drop_schemas
  connection = ActiveRecord::Base.connection.raw_connection

  schemas = connection.query(%Q{
    SELECT 'drop schema' || nspname || ' cascade;'
    FROM pg_namespace
    WHERE nspname != 'public'
    AND nspname NOT LIKE 'pg_%'
    AND nspname != 'information_schema';
  })

  schemas.each do |query|
    connection.query(query.values.first)
  end
end

def sign_user_in user, opts
  page.driver.post user_session_url(subdomain: opts[:subdomain]),
                   email: opts[:email] || user.email,
                   password: opts[:password] || user.password,
                   format: :json
end

def set_auth_request driver, user   
  driver.header('X-User-Email', user.email)
  driver.header('X-User-Token', user.authentication_token)
end

def set_header user
  header 'X-User-Email', user.try(:email)
  header 'X-User-Token', user.try(:authentication_token)
end

def create_on_schema factory, schema_name
  Apartment::Tenant.switch schema_name
  created = create factory
  Apartment::Tenant.reset

  created
end

def on_schema schema_name
  Apartment::Tenant.switch schema_name
  yield
  Apartment::Tenant.reset
end