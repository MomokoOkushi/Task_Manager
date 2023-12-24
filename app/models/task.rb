class Task < ApplicationRecord
  has_many :task_users, dependent: :destroy
  has_many :users , through: :task_users
  has_many :comments, dependent: :destroy
  belongs_to :group
  belongs_to :user
  accepts_nested_attributes_for :task_users #タスク編集機能において、updateするモデルをネストする

  validates :title, presence: true

  def save_task_users(user_ids) #投稿機能において、TaskUserモデルにも一度にtask_userデータを保存する
    task_users.destroy_all
    user_ids.each do |user_id|
      TaskUser.create(user_id: user_id, task_id: id)
    end
  end

  def update_task_users(user_ids)
    user_ids.each do |user_id|
    TaskUser.create(user_id: user_id, task_id: id)
    end
  end
end


