class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users , through: :group_users
  has_many :tasks, dependent: :destroy

  validates :name, presence: true

  def includesUser?(user) #グループ内に指定されたuserが存在するか確かめる。グループ一覧にて使用。
    group_users.exists?(user_id: user.id)
  end

  def self.search_for(content) #検索機能：部分一致のみ適用。
    Group.where('name LIKE ?', '%' + content + '%')
  end
end
