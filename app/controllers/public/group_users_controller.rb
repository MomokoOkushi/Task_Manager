class Public::GroupUsersController < ApplicationController
  before_action :authenticate_user!

  def create
    group_user = current_user.group_users.new(group_id: params[:group_id])
    if group_user.save
      flash[:notice] = "グループに参加しました"
      redirect_to public_group_path(params[:group_id])
    else
      flash[:notice] = "グループへの参加に失敗しました。もう一度参加してください"
      redirect_to request.referer
    end
  end

  def destroy
    group_user = current_user.group_users.find_by(group_id: params[:group_id])
    if group_user.destroy
      flash[:notice] = "グループから退会しました"
      redirect_to request.referer
    else
      flash[:notice] = "グループからの退会に失敗しました。もう一度退会してください"
      render 'index'
    end
  end
end
