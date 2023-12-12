class AddSendUserToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :send_user, :integer
  end
end
