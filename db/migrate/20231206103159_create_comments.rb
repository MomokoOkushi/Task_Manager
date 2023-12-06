class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false
      t.integer :task_id, null: false
      t.text :message, null: false
      t.timestamps
    end

  end
end
