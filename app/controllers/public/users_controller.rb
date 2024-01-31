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
    #送信者名の重複を防いだ状態で新着メッセージを取り出す。(Message.rbにて定義)
    @ordered_messages = Message.received_latest_messages(current_user)
  end

  def update
    @user = User.find(current_user.id)
     if @user.update(user_params)
      flash[:success] = "正常に更新されました。"
      redirect_to public_my_page_path
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
