class AddScoreToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :score, :decimal, precision: 5, scale: 3
  end
end
