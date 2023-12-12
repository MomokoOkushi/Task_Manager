class Public::UsersController < ApplicationController
  def show #編集画面も
  end

  def index
    @users = User.all
  end
  
  def update
    
  end
end
