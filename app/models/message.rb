class Message < ApplicationRecord
  belongs_to :send_user, class_name: 'User' #DM機能のリレーション：送信者IDをUserモデルからとってくる
  belongs_to :receive_user, class_name: 'User' #DM機能リレーション：受信者IDをUserモデルからとってくる

  validates :message, presence: true
end
