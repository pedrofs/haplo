class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.eager_load(:role).find_by! id: params[:id]
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  def update
    @user = User.find_by! id: params[:id]

    @user.update_attributes params_user

    render :show, status: :ok
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  def destroy
    @user = User.find_by! id: params[:id]

    respond_with @user.destroy!

    rescue ActiveRecord::RecordNotDestroyed
      render json: {flash: 'Não foi possível deletar o usuário.'}, status: :bad_request
    rescue ActiveRecord::RecordNotFound
      render_not_found
  end

  def params_user
    params.require(:user).permit(:name, :email, :image, :role_id)
  end
end