class MessagesController < ApplicationController
  def index
    @sended_messages = current_user.messages
    @received_messages = current_user.reverses_of_message
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
  end

  def create
    receiver = User.find_by(name: message_params[:receive_user_name])
    content = message_params[:content]
    @message = Message.new(send_user: current_user, receive_user: receiver, content: content)
    if @message.save
      flash[:success] = 'メッセージを送信しました'
      redirect_to messages_url
    else
      flash.now[:danger] = 'メッセージの送信に失敗しました'
      render :new
    end
  end
  
  private
  
  def message_params
    params.require(:message).permit(:receive_user_name, :content)
  end
  
end
