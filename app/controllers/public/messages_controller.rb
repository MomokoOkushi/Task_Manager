class Public::MessagesController < ApplicationController

  def create
    @messages = Message.new(message_params)
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

  def message
    @message = Message.new
    @messages = Message.where(send_user_id: current_user.id,
                              receive_use_idr: params[:id]).or(@receive_messages = Message.where(send_user_id: params[:id],
                                                                                              receive_user_id: current_user.id)).order(:created_at)
  end

  private
  def message_params
    params.require(:message).permit(:receive_user, :message)
  end
end
