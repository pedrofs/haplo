class InvitationsController < ApplicationController

  skip_before_filter :authenticate_user_from_token!, :authenticate_user!, only: :update

  def create
    @user = invite_resource

    if @user.errors.empty?
      render json: @user, status: :created
    else
      render_errors @user
    end
  end

  def update
    resource = accept_resource

    if resource.errors.empty?
      sign_in resource, store: false

      render json: { auth_token: resource.authentication_token, email: resource.email, email: resource.email }, status: :ok
    else
      render_errors resource
    end
  end

  protected

  def invite_resource(&block)
    User.invite!(invite_params, current_user, &block)
  end
  
  def accept_resource
    User.accept_invitation!(update_resource_params)
  end

  def invite_params
    devise_parameter_sanitizer.for(:invite)
    devise_parameter_sanitizer.sanitize(:invite)
  end

  def update_resource_params
    devise_parameter_sanitizer.for(:accept_invitation).concat [:name, :role_id]
    devise_parameter_sanitizer.sanitize(:accept_invitation)
  end

  private

  def devise_parameter_sanitizer
    @devise_parameter_sanitizer ||= Devise::ParameterSanitizer.new(User, 'user', params)
  end
end