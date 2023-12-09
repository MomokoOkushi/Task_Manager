class Public::TasksController < ApplicationController
  def new
    @task = Task.new
    @group = Group.find(params[:group_id])
  end

  def create
    @task = Task.new(task_params)
    group = Group.find(params[:group_id])
    @task.group_id = group.id
    @task.user_id = current_user.id
    if @task.save
      @task.save_task_users(params[:user_ids])
      redirect_to public_group_task_path(params[:group_id], @task)
    else
      redirect_to request.referer
    end

  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
  end

  def update

  end

  def destroy

  end

  private
    def task_params
      params.permit(:title, :detail, :start_time)
    end

end
