class RenameReceiveUserColumnToMassages < ActiveRecord::Migration[6.1]
  def change
    rename_column :messages, :receive_user, :receive_user_id
  end
end
