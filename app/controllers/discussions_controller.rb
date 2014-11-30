class DiscussionsController < ApplicationController
  def index
    targetable_id = params[:targetable_id]
    targetable_type = params[:targetable_type]
    user_id = params[:user_id]

    if targetable_type and targetable_id
      @discussions = Discussion.load_associations.for_target(targetable_id, targetable_type)
    elsif user_id
      @discussions = Discussion.load_associations.for_user(user_id)
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
    discussion = Discussion.find_by! id: params[:id]

    discussion.update_attributes! params_discussion

    render json: {discussion: discussion.to_builder.attributes!, flash: 'Discussão alterada com sucesso.', status: 'success'}
  rescue ActiveRecord::RecordNotFound
    render_not_found
  rescue ActiveRecord::RecordInvalid
    render_errors discussion
  end

  def destroy
    discussion = Discussion.find_by! id: params[:id]

    discussion.destroy!

    render json: {flash: 'Discussão removida com sucesso.', status: 'success'}
  rescue ActiveRecord::RecordNotDestroyed
    render json: {flash: 'Não foi possível remover a discussão.', type: 'danger'}, status: :bad_request
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  private

  def params_discussion
    params.require(:discussion).permit(:content, :title)
  end

  def is_targetable? klass
    klass.included_modules.include? Targetable
  end
end