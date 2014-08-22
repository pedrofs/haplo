class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  respond_to :json

  before_filter :authenticate_user_from_token!, :authenticate_user!, :set_mailer_host
  after_filter :set_csrf_headers

protected

  def render_not_found
    render json: { errors: '404 not found' }, status: :not_found
  end

  def render_errors model
    render json: { errors: model.errors },
           status: :unprocessable_entity
  end

  def current_account
    @current_account ||= Account.find_by subdomain: request.subdomain
  end

  def authenticate_user_from_token!
    if user_token = params[:user_token].blank? && request.headers["X-User-Token"]
      params[:user_token] = user_token
    end
    if user_email = params[:user_email].blank? && request.headers["X-User-Email"]
      params[:user_email] = user_email
    end
 
    user_email = params[:user_email].presence
    user = user_email && User.find_by(email: user_email)

    if user && Devise.secure_compare(user.authentication_token, params[:user_token])
      sign_in user, store: false
    end
  end

  def set_csrf_headers
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

  def set_mailer_host
    subdomain = current_account ? "#{current_account}." : ""

    ActionMailer::Base.default_url_options[:host] = "#{subdomain}lvh.com:3000"
  end
end
