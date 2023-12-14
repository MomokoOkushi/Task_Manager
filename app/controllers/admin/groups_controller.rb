class Admin::GroupsController < ApplicationController

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @tasks = @group.tasks.includes(:users)
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to request.referer
  end
end
