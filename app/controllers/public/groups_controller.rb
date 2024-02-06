class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :group_has_login_user,only: [:show]

  def create
    @my_groups = current_user.groups #ログインユーザーが参加しているグループ
    @groups = Group.all
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
    @my_groups = current_user.groups #ログインユーザーが参加しているグループ
    @groups = Group.all
    @group = Group.new

    #検索フォームにパラメーターが送られた場合、検索結果をページ内に表示する
    @content = params[:content]
    if @content
      @records = Group.search_for(params[:content])
    end
  end

  def show #グループ詳細画面(グループタスク一覧を兼ねる)
    @group = Group.find(params[:id])
    @tasks = @group.tasks.includes(:users)
    @calendar_type = params[:calendar_type] #ページ内のクエリパラメータを受け取り、タスクの表示形式を切り替える
  end

  private
    def group_params
      params.require(:group).permit(:name)
    end

    def group_has_login_user #ログインユーザーがグループに所属していない場合はアクセスできないようにする
      group = Group.find(params[:id])
      unless group.group_users.exists?(user_id: current_user.id)
        flash[:notice] = "グループに参加してから再度試してください"
        redirect_to  public_groups_path
      end
    end
end
