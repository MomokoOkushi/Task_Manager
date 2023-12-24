class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @user_groups = Group.includes(:group_users).where(group_users: {user_id: @user.id})
    @user_tasks = Task.includes(:task_users).where(task_users: {user_id: @user.id})
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      flash[:success] = "アカウントが削除されました"
      redirect_to admin_users_path
    else
      flash[:notice] = "アカウントの削除に失敗しました。もう一度削除してください"
      redirect_to request.referer
    end
  end
end
