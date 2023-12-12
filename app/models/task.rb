class Task < ApplicationRecord
  has_many :task_users, dependent: :destroy
  has_many :users , through: :task_users
  has_many :comments, dependent: :destroy
  belongs_to :group
  belongs_to :user
  accepts_nested_attributes_for :task_users
  
  
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
   def update_task_users(user_ids)
    user_ids.each do |user_id|
      TaskUser.create(user_id: user_id, task_id: id)
    end
  end
end

# [1,2,3,4].each do |user|
#     TaskUser.create(user_id: user_id, task_id: id)
# end

# [{user_id: 1, status: 0, conplete: false},{user_id: 1, status: 0, conplete: false} ]