class AddReceiveUserToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :receive_user, :integer
  end
end
