class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def show #編集画面も兼ねる
    @user = User.find(current_user.id)
  end

  def index
    @users = User.all
    @content = params[:content] #検索フォームからパラメーターが送られた場合に検索結果を表示する
    if @content
      @records = User.search_for(params[:content])
    end
    @new_messages = Message.where(receive_user_id: current_user.id).order(created_at: :desc).limit(100)
  end

  def update
    @user = User.find(current_user.id)
     if @user.update(user_params)
      flash[:success] = "正常に更新されました。"
      redirect_to request.referer
     else
      flash[:notice] = "更新に失敗しました。"
      render 'show'
     end
  end

  private
  def user_params
    params.require(:user).permit(:name, :department)
  end
end
