class Public::GroupsController < ApplicationController
  before_action :authenticate_user!

  def create
    @my_groups = current_user.groups
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
    @my_groups = current_user.groups
    @groups = Group.all
    @group = Group.new
    @content = params[:content] #検索フォームにパラメーターが送られたら、検索結果をページ内に表示する
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
end
