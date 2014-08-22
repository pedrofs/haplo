class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    resource = User.find_for_database_authentication email: params[:email]
    return invalid_login_attempt unless resource
 
    if resource.valid_password? params[:password]
      resource.authentication_token = resource.generate_authentication_token
      resource.save!

      sign_in resource, store: false

      render json: { auth_token: resource.authentication_token, email: resource.email, email: resource.email }, status: :ok

      return
    end

    invalid_login_attempt
  end
  
  def destroy
    current_user.update_attribute :authentication_token, nil

    sign_out resource_name

    head :no_content
  end
 
  protected
 
  def invalid_login_attempt
    warden.custom_failure!

    render json: { message: "Error with your email or password" }, status: :unauthorized
  end
end