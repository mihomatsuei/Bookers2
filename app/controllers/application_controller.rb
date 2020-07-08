class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, only: [:show,:edit,:index]

  def after_sign_in_path_for(resource)
# 新規登録後のリダイレクト先をusers#showにしてWelcome! You have signed up successfully.を表示
        flash[:notice] = "Welcome! You have signed up successfully."
        user_path(resource)  #users#show
  end
  def after_sign_out_path_for(resource)
# ログアウトのリダイレクト先をhomes#topにしてSigned out successfullyを表示
        flash[:notice] = "Signed out successfully."
        root_path  #homes#top
  end
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end


end
