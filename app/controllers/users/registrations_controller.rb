class Users::RegistrationsController < Devise::RegistrationsController
  def update
    current_user.update user_params
    redirect_to :back, notice: "更新しました。"
  end

  def create
    if user = (User.find_by_email user_params[:email])
      user.update user_params.merge({
        provider: (attrs = session["user_attrs"])["provider"],
        uid: attrs["uid"],
        icon_url: attrs["info"]["image"]
      })
      sign_in user
      redirect_to root_path
    else
      super
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email)
  end
end

