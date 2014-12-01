class CommentsController < ApplicationController
  def create
    @comment = Comment.new comment_params

    @comment.user = current_user

    @comment.save!

    render json: { comment: @comment.to_builder.attributes!, flash: 'Comentário criado com sucesso.', type: 'success' }, status: :created

  rescue ActiveRecord::RecordInvalid
    render_errors @comment
  end

  def update
    @comment = Comment.find_by! id: params[:id]

    @comment.update_attributes! comment_params

    render json: { comment: @comment.to_builder.attributes!, flash: 'Comentário atualizado com sucesso.', type: 'success' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render_not_found
  rescue ActiveRecord::RecordInvalid
    render_errors @comment
  end

  def destroy
    @comment = Comment.find_by! id: params[:id]

    @comment.destroy!

    render json: {flash: 'Comentário deletado com sucesso.', type: 'success'}, status: :ok
  rescue ActiveRecord::RecordNotDestroyed
    render json: {flash: 'Não foi possível deletar o comentário.', type: 'danger'}, status: :bad_request
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :discussion_id)
  end
end