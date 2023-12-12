class RenameSendUserColumnToMassages < ActiveRecord::Migration[6.1]
  def change
    rename_column :messages, :send_user, :send_user_id
  end
end
