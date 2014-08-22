class AccountsController < ApplicationController
  skip_before_filter :authenticate_user_from_token!, only: [:create]
  skip_before_filter :authenticate_user!, only: [:create]

  def create
     @account = Account.new account_params
     account_setup = AccountSetup.new

     account_setup.setup @account

     @account.save!
    
     respond_with @account, code: :created

     rescue ActiveRecord::RecordInvalid
       render_errors @account
  end

  def destroy
    @account = Account.find_by! id: params[:id]

    respond_with @account.destroy!

    rescue ActiveRecord::RecordNotFound
      render_not_found
  end

  private

  def account_params
    params.require(:account).permit(:subdomain, owner_attributes: [:name, :email, :password, :password_confirmation])
  end
end