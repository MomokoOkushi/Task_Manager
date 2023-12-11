class Task < ApplicationRecord
  has_many :task_users, dependent: :destroy
  has_many :users , through: :task_users
  belongs_to :group
  belongs_to :user
  
  # def task_uses
  #   TaskUsers.where(task_id: self.id)
  # end
  
  # def users
  #   User.where(id: self.task_users.pluck(:user_id))
  # end
  
  def save_task_users(user_ids)
    task_users.destroy_all
    user_ids.each do |user_id|
      TaskUser.create(user_id: user_id, task_id: id)
    end
  end
end
