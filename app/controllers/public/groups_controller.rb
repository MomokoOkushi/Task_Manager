class Public::GroupsController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to public_groups_path #, method: :post
    else
      render 'index'
    end
  end

  def index
    @group = Group.new
    @groups = Group.all
    @my_group = GroupUser.where(user_id: current_user.id) #ユーザーが所属しているグループを抽出
    @group_user
  end

  def show
  end

  def edit

  end

  def update
    if @group.save
      redirect_to public_group_path
    else
      render 'edit'
    end
  end

  def weekly

  end

  def calender

  end

  private
    def group_params
      params.require(:group).permit(:name)
    end

end
