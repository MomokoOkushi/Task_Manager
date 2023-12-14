class Public::UsersController < ApplicationController
  def show #編集画面も兼ねる
    @user = User.find(current_user.id)
  end

  def index
    @users = User.all
  end

  def update
    @user = User.find(current_user.id)
    @user.update(user_params)
    redirect_to request.referer
  end

  private
  def user_params
    params.require(:user).permit(:name, :department)
  end
end
