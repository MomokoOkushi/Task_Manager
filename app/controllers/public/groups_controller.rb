class Public::GroupsController < ApplicationController
  before_action :authenticate_user!

  def create
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
    model = params[:model]
    if model #検索paramsが来たら以下の分岐を追加
      @model = model
      @content = params[:content]
      if model == "user"
        @records = User.search_for(params[:content], params[:method])
      else
        @records = Group.search_for(params[:content], params[:method])
      end
    end
  end

  def show
    @group = Group.find(params[:id])
    @tasks = @group.tasks.includes(:users)
    #@tasks = @group.tasks.includes(:users).where('users.name': "yamada")
    #@task_users = User.includes(:task_users).where(task_users: {task_id: @tasks.ids})
    # post.rb
    # belongs_to user
    # Post.includes(:user).where(users: {gender: "men"})


    # task.rb
    # has_many :tags
    # Task.includes(:tggs).where(tags: {name: params[:q]})
  end

  def update
    if @group.save
      redirect_to public_group_path
    else
      render 'edit'
    end
  end

  def weekly
    @group = Group.find(params[:group_id])
    @tasks = @group.tasks
  end

  def calender
    @group = Group.find(params[:group_id])
    @tasks = @group.tasks
  end

  private
    def group_params
      params.require(:group).permit(:name)
    end
end
