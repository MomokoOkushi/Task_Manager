class Public::GroupUsersController < ApplicationController
  before_action :authenticate_user!

  def create
    group_user = current_user.group_users.new(group_id: params[:group_id])
    if group_user.save
      redirect_to public_group_path(params[:group_id])
    else
      flash[:alert] = "参加できませんでした。"
      redirect_to request.referer
    end
  end

  def destroy
    group_user = current_user.group_users.find_by(group_id: params[:group_id])
    group_user.destroy
    redirect_to request.referer
  end

end
