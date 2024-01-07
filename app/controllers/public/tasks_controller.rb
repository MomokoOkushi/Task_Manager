class Public::TasksController < ApplicationController
  before_action :authenticate_user!

  def new
    @task = Task.new
    @group = Group.find(params[:group_id])
  end

  def create
    @task = Task.new(new_task_params)
    @task.score = Language.get_data(new_task_params[:detail]) #自然言語処理APIから返ってきた値を保存
    @group = Group.find(params[:group_id])
    @task.group_id = @group.id                #tasksテーブルのグループIDカラムに現在のグループIDを割り当てる
    @task.user_id = current_user.id           #tasksテーブルのユーザーIDカラムには、タスク作成者としてログイン中のユーザーIDを割り当てる
    if @task.save
      @task.save_task_users(params[:user_ids])
      flash[:notice] = "新しいタスクを作成しました"
      redirect_to public_group_task_path(params[:group_id], @task)
    else
      flash[:notice] = "新しいタスク作成に失敗しました。もう一度作成してください"
      render 'new'
    end
  end

  def show
    @task = Task.find(params[:id])
    @group = @task.group
    @task_statuses = TaskUser.where(user_ids: @group.users) #複数人のタスク担当者の進捗状況のデータを取得
    @comment = Comment.new
  end

  def my_tasks #ログイン中ユーザーのタスク一覧
    @task_users = TaskUser.where(user_id: current_user.id)
    @tasks = Task.includes(:task_users).where(task_users: {user_id: current_user.id})
    @calendar_type = params[:calendar_type] #ページ内のクエリパラメータを受け取り、タスクの表示形式を切り替える
  end

  def edit
    @task = Task.find(params[:id])
    @group = @task.group
  end

  def update
    @task = Task.find(params[:id])
    @task.score = Language.get_data(update_task_params[:detail]) #自然言語処理APIから返ってきた値を保存
    if @task.update(update_task_params)
      redirect_to public_group_task_path(@task.group, @task)
      flash[:success] = "タスクが正常に更新されました。"
    else
      flash[:notice] = "タスクの更新に失敗しました。もう一度更新してください"
      render 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if@task.destroy
      flash[:success] = "タスクが削除されました"
      redirect_to public_group_path(@task.group_id)
    else
      flash[:notice] = "タスクの削除に失敗しました。もう一度削除してください"
      render 'edit'
    end
  end

  private
    def new_task_params
      params.permit(:title, :detail, :start_time)
    end
    def update_task_params
      params.require(:task).permit(:title, :detail, :start_time, task_users_attributes:[:task_status, :is_complete, :id])
    end
end
