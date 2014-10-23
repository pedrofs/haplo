class RolesController < ApplicationController
  def index
    @roles = Role.all
    respond_with @roles
  end

  def show
    @role = Role.find_by id: params[:id]

    respond_with @role
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  def create
    @role = Role.new role_params

    @role.save!

    render json: @role, status: :created
  rescue ActiveRecord::RecordInvalid
    render_errors @role
  end

  def update
    @role = Role.find_by! id: params[:id]

    @role.update_attributes! role_params

    render json: @role, status: :ok
  rescue ActiveRecord::RecordInvalid
    render_errors @role
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  def destroy
    @role = Role.find_by! id: params[:id]

    respond_with @role.destroy!

    rescue ActiveRecord::RecordNotDestroyed
      render json: {flash: 'Não foi possível deletar o role.'}, status: :bad_request
    rescue ActiveRecord::RecordNotFound
      render_not_found
  end

  private

  def role_params
    params.require(:role).permit(:name)
  end
end