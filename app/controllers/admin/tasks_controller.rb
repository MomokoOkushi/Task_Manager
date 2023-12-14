class Admin::TasksController < ApplicationController
  def show
    @group = Group.find(params[:group_id])
    @task = Task.find(params[:id])
    @task_statuses = TaskUser.where(user_ids: @group.users)
    @comment = Comment.new
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to admin_group_path(task.group_id)
  end
end
