class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    user_signed_in? ? update_user : sign_in_or_register
  end

  private
    def update_user
      current_user.update provider: auth_env.provider, uid: auth_env.uid
      redirect_to :back, notice: "連携しました。"
    end

    def sign_in_or_register
      if user = User.find_by(
        provider: auth_env.provider,
        uid: auth_env.uid
      )
        sign_in_and_redirect user
      else
        session["user_attrs"] = auth_env.except(:extra)
        redirect_to new_user_registration_url
      end
    end

    def auth_env
      request.env["omniauth.auth"]
    end
end
