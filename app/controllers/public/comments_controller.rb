class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @task = Task.find(params[:task_id])
    comment = current_user.comments.new(comment_params)
    comment.task_id = @task.id
    comment.save
  end

  private
  def comment_params
    params.require(:comment).permit(:message)

  end
end
