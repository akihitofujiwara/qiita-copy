class CommentsController < ApplicationController
  before_action :set_item, only: %i(create destroy)
  before_action :set_comment, only: %i(destroy)

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

  def set_item
    @item = Item.find params[:item_id]
  end

  def set_comment
    @comment = @item.comments.find params[:id]
  end
end
