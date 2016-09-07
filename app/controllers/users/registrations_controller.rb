class Users::RegistrationsController < Devise::RegistrationsController
  def update
    current_user.update user_params
    redirect_to :back, notice: "更新しました。"
  end

  private
  def user_params
    params.require(:user).permit(:username, :email)
  end
end

