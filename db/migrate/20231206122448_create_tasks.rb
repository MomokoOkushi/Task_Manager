class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|

      t.integer :user_id, null: false #タスク管理者ID
      t.integer :group_id, null: false
      t.string :title, null: false
      t.text :detail, null: false, default: ""
      t.datetime :start_time, null: false
      t.timestamps
    end
  end
end
