class Message < ApplicationRecord
  belongs_to :send_user, class_name: 'User' #DM機能のリレーション：送信者IDをUserモデルからとってくる
  belongs_to :receive_user, class_name: 'User' #DM機能リレーション：受信者IDをUserモデルからとってくる

  validates :message, presence: true

  #usersコントローラーindexアクションにて使用。(self = Messageモデル)
  #送信者名の重複を防いだ状態で新着メッセージを取り出す。
  def self.received_latest_messages(current_user)
    send_user_ids = where(receive_user_id: current_user.id).pluck(:send_user_id).uniq #where直前のselfを省略済。
    send_user_ids.map{|send_user_id|latest_message(send_user_id, current_user) }.sort_by{|message| message.created_at}.reverse
  end

  def self.latest_message(send_user_id, current_user) #received_latest_messagesメソッドにて使用
    where(send_user_id: send_user_id, receive_user_id: current_user.id).last
  end
end
