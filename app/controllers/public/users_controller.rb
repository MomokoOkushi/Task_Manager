class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def show #編集画面も兼ねる
    @user = User.find(current_user.id)
  end

  def index
    @users = User.all
    @model = params[:user]
    if @content = params[:content]
      if @model = "user"
        @records = User.search_for(params[:content], params[:method])
      else
        @records = Group.search_for(params[:content], params[:method])
      end
    end
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
