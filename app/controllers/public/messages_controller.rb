class Public::MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @message = Message.new(message_params)
    @message.send_user_id = current_user.id
    if @message.save!
      @messages = Message.where(send_user_id: current_user.id,
                                receive_user_id: params[:message][:receive_user_id]).or(@receive_messages = Message.where(
                                  send_user_id: params[:message][:receive_user_id], receive_user_id: current_user.id
                                  )).order(:created_at)
    else
      @message = Message.new
      @messages = Message.where(send_user_id: current_user.id,
                                receive_user_id: params[:message][:receive_user_id]).or(@receive_messages = Message.where(
                                  send_user_id: params[:message][:receive_user_id], receive_user_id: current_user.id
                                  )).order(:created_at)
    end
  end

  def message #１対１のDM画面
    @message = Message.new
    @messages = Message.where(send_user_id: current_user.id,
                              receive_user_id: params[:id]).or(@receive_messages = Message.where(send_user_id: params[:id],
                                                                                              receive_user_id: current_user.id)).order(:created_at)
    @receive_user = User.find(params[:id])
  end

  private
  def message_params
    params.require(:message).permit(:receive_user_id, :message)
  end
end
