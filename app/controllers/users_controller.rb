class UsersController < ApplicationController
  before_action :set_user, only: %i(show)

  def unlink_twitter
    current_user.update provider: nil, uid: nil
    redirect_to edit_user_registration_path(current_user), notice: "連携を解除しました。"
  end

  private
    def set_user
      @user = User.find params[:id]
    end
end
