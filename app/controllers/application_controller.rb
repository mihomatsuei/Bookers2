class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
# 新規登録後のリダイレクト先をbooks#indexにしてWelcome! You have signed up successfully.を表示
    def after_sign_in_path_for(resource)
      if @user.save #もしsign upが成功したら
        flash[:notice] = "Welcome! You have signed up successfully." 
        root_books_path  #　books#index
      else #エラーが出たら
        render :sign_up #sign upのままerrorを表示させたい
    end
end

end
