class WelcomeController < ApplicationController
  skip_before_filter :authenticate_user_from_token!
  skip_before_filter :authenticate_user!

  layout "public"

  def index
  end

  def login
  end
end