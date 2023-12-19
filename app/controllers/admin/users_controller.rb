class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      flash[:success] = "アカウントが削除されました"
      redirect_to request.referer
    else
      flash[:notice] = "アカウントの削除に失敗しました。もう一度削除してください"
      redirect_to request.referer
    end
  end
end
