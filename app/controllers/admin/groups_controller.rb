class Admin::GroupsController < ApplicationController

  def index
    @groups = Group.all
  end

  def show

  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to request.referer
  end
end
