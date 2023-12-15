class Admin::GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @tasks = @group.tasks.includes(:users)
  end

  def destroy
    group = Group.find(params[:id])
    if group.destroy
      flash[:success] = "グループの削除に成功しました"
      redirect_to request.referer
    else
      flash[:notice] = "グループの削除に失敗しました。もう一度削除してください"
      redirect_to request.referer
    end
  end
end
