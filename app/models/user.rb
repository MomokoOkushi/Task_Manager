class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :group_users, dependent: :destroy #グループ機能のリレーション
  has_many :groups, through: :group_users

  has_many :task_users, dependent: :destroy
  has_many :tasks , through: :task_users, source: :task
  has_many :comments, dependent: :destroy

  has_many :sent_messages, class_name:"Message", foreign_key:"send_user", dependent: :destroy
  has_many :received_massages, class_name:"Message", foreign_key:"receive_user", dependent: :destroy

def self.search_for(content, method)
  if method == 'perfect'
    User.where(name: content)
  elsif method == 'forward'
    User.where('name LIKE ?', content + '%')
  elsif method == 'backward'
    User.where('name LIKE ?', '%' + content)
  else
    User.where('name LIKE ?', '%' + content + '%')
  end
end

end
