class UsersController < ApplicationController

before_action :authenticate_user!, only: [:show,:edit,:index]


  def show
  	@user = User.find(params[:id])
  	@book = Book.new
  	@books = @user.books
  end

  def edit
  	 @user = User.find(params[:id])
  if @user == current_user
  else
    redirect_to user_path(current_user.id)
  end
  end

  def update
     @user = User.find(params[:id])
  if @user.update(user_params)
     flash[:notice] = "You have updated user successfully."#
     redirect_to user_path(@user.id)#show画面へ
  else
     render :edit #編集画面のままerrorを表示させたい(edit)
  end
  end

  def index
  @users = User.all
  @user = current_user
  @book = Book.new

  end

private
def user_params
  params.require(:user).permit(:name, :profile_image, :introduction)
end

end
