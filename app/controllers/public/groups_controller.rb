class Public::GroupsController < ApplicationController
  before_action :authenticate_user!

  def create
    @my_groups = current_user.groups
    @groups = Group.all
    @group = Group.new(group_params)
    if @group.save
      flash[:notice] = "新しいグループを作成しました"
      redirect_to public_groups_path
    else
      flash[:notice] = "新しいグループの作成に失敗しました。もう一度作成してください"
      render 'index'
    end
  end

  def index
    @my_groups = current_user.groups
    @groups = Group.all
    @group = Group.new
    @content = params[:content]
    if @content
      @records = Group.search_for(params[:content])
    end
  end

  def show
    @group = Group.find(params[:id])
    @tasks = @group.tasks.includes(:users)
    @calendar_type = params[:calendar_type]
  end

  def update
    if @group.save
      redirect_to public_group_path
    else
      render 'edit'
    end
  end

  private
    def group_params
      params.require(:group).permit(:name)
    end
end
