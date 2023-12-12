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
  
  
  
end
