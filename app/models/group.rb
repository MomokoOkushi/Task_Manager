class Group < ApplicationRecord

  has_many :group_users, dependent: :destroy
  has_many :users , through: :group_users
  has_many :tasks, dependent: :destroy

def includesUser?(user) #グループ内に指定されたuserが存在するか確かめる
  group_users.exists?(user_id: user.id)
end

def self.search_for(content, method)
  if method == 'perfect'
    Group.where(name: content)
  elsif method == 'forward'
    Group.where('name LIKE ?', content + '%')
  elsif method == 'backward'
    Group.where('name LIKE ?', '%' + content)
  else
    Group.where('name LIKE ?', '%' + content + '%')
  end
end

end
