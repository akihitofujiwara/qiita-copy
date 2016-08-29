class FollowingsController < ApplicationController
  before_create_or_destroy :set_user_and_tag_by_params

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
end

