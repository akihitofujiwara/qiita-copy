class CommentsController < ApplicationController
  before_create_or_destroy :set_item_by_params
  before_destroy :set_comment_by_params_from_item

  def create
    current_user.comments.create (comment_params.merge commentable: @item)
    redirect_to :back
  end

  def destroy
    @comment.destroy
    redirect_to :back
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
