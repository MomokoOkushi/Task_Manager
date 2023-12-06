class CreateTaskUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :task_users do |t|
      
      t.integer :task_id, null: false
      t.integer :user_id, null: false
      t.integer :task_status, null: false, default: 0 #タスクの進捗を表す
      t.boolean :is_complete, null: false, default: false #タスク管理者が履行確認をしたかを表す
      t.timestamps
    end
  end
end
