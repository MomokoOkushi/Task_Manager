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

  end

  def calender

  end

  private
    def group_params
      params.require(:group).permit(:name)
    end

end
