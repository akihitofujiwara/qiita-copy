class FollowingsController < ApplicationController
  before_action :set_user, :set_tag, only: %i(create destroy)

  def create
    current_user.follow followee
    redirect_to :back
  end

  def destroy
    current_user.unfollow followee
    redirect_to :back
  end

  private
  def followee
    @user || @tag
  end

  def set_user
    @user = User.find params[:user_id] if params[:user_id].present?
  end

  def set_tag
    @tag = Tag.find params[:tag_id] if params[:tag_id].present?
  end
end

