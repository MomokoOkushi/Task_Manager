class Group < ApplicationRecord

  has_many :group_users, dependent: :destroy
  has_many :users , through: :group_users
  has_many :tasks, dependent: :destroy

  def includesUser?(user) #グループ内に指定されたuserが存在するか確かめる
    group_users.exists?(user_id: user.id)
  end

  def self.search_for(content)
    Group.where('name LIKE ?', '%' + content + '%')
  end
end
