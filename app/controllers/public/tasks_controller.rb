class Public::TasksController < ApplicationController
  def new
    @task = Task.new
    @group = Group.find(params[:group_id])
  end

  def create
    @task = Task.new(new_task_params)
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
    @group = @task.group
    @task_statuses = TaskUser.where(user_ids: @group.users)
    @comment = Comment.new
  end

  def edit
    @task = Task.find(params[:id])
    @group = @task.group

  end

  def update
    @task = Task.find(params[:id])
    if @task.update(update_task_params)
      redirect_to public_group_task_path(@task.group, @task)
       flash[:success] = "タスクが正常に更新されました。"
    else
      render 'edit'
    end
  end

  def destroy

  end

  private
    def new_task_params
      params.permit(:title, :detail, :start_time)

    end

    def update_task_params
      params.permit(:title, :detail, :start_time, :task_status, user_ids:[])
    end

end
