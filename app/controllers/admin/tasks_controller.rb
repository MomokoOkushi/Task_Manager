class Admin::TasksController < ApplicationController
  before_action :authenticate_admin!

  def show
    @group = Group.find(params[:group_id])
    @task = Task.find(params[:id])
    @task_statuses = TaskUser.where(user_ids: @group.users)
    @comment = Comment.new
  end

  def destroy
    task = Task.find(params[:id])
    if task.destroy
      flash[:success] = "タスクが削除されました"
      redirect_to admin_group_path(task.group_id)
    else
      flash[:notice] = "タスクの削除に失敗しました。もう一度削除してください"
      redirect_to request.referer
    end
  end
end
