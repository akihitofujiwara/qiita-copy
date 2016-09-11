class ApplicationController < ActionController::Base
  before_action :configure_devise_params, if: :devise_controller?
  protect_from_forgery with: :exception

  private
  def configure_devise_params
    devise_parameter_sanitizer.permit(:sign_up, keys:[:username])
  end
end
