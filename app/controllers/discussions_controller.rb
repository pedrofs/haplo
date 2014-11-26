class DiscussionsController < ApplicationController
  def index
    targetable_id = params[:targetable_id]
    targetable_type = params[:targetable_type]
    user_id = params[:user_id]

    if targetable_type and targetable_id
      @discussions = Discussion.joins(:targets).where("targets.targetable_id = ? and targets.targetable_type = ?", targetable_id, targetable_type)
    elsif user_id
      @discussions = Discussion.where user_id: user_id
    else
      render_not_found
    end
  end

  def show
    discussion = Discussion.find_by! id: params[:id]

    render json: discussion.to_builder.attributes!
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  def create
    targetableClass = params[:targetable_type].constantize

    raise NameError unless is_targetable? targetableClass

    targetable = targetableClass.find_by! id: params[:targetable_id]
    discussion = Discussion.new params_discussion
    discussion.user = current_user
    discussion.build_targets_from_targetable targetable

    discussion.save!

    render json: { discussion: discussion.to_builder.attributes!, flash: 'Discussão criada com sucesso.', status: 'success' }, status: :created
  rescue ActiveRecord::RecordInvalid
    render_errors discussion
  rescue NameError
    render_not_found
  end

  def update
  end

  def destroy
  end

  private

  def params_discussion
    params.require(:discussion).permit(:content)
  end

  def is_targetable? klass
    klass.included_modules.include? Targetable
  end
end