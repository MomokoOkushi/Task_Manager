class Group < ApplicationRecord
  
  has_many :group_users, dependent: :destroy
  
  #与えられたユーザーがグループに所属しているか確認する
  def includesUser?(user)
      group_users.exists?(user_id: user.id)
  end
end
