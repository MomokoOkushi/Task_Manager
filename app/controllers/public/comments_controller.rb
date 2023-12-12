class Public::CommentsController < ApplicationController

  def create
    task = Task.find(params[:task_id])
    comment = current_user.comments.new(comment_params)
    comment.task_id = task.id
    comment.save
    redirect_to public_group_task_path(task.group, task)
  end

  def destroy

  end

  private
  def comment_params
    params.require(:comment).permit(:message)

  end
end
