class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @group = Group.find(params[:group_id])
    @task = @group.tasks.find(params[:task_id])
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:success] = "コメントの削除に成功しました"
      redirect_to request.referer
    else
      flash[:notice] = "コメントの削除に失敗しました。もう一度削除してください"
      redirect_to request.referer
    end
  end

end
