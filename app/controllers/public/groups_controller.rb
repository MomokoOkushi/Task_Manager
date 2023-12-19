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
    @group = Group.new
    @groups = Group.all
    @my_groups = current_user.groups
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
    @tasks = Task.find_by(group_id: params[:group_id])
    @group = Group.find(params[:group_id])
  end

  def calender
    @tasks = Task.find_by(group_id: params[:group_id])
    @group = Group.find(params[:group_id])
  end

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]

    if @model == "user"
      @records = User.search_for(@content, @method)
    else
      @records = Group.search_for(@content, @method)
    end
    redirect_to public_groups_path
  end

  private
    def group_params
      params.require(:group).permit(:name)
    end

end
