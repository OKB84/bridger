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
    @receive_user = User.find(params[:user_id])
    @chosen_plan = LessonPlan.find_by(id: params[:plan_id])
    if @chosen_plan
      @default_message = 
      "はじめまして。\r#{current_user.name}と申します。\r\r以下の内容でレッスンを受講させていただきたいのですが、ご都合はいかがでしょうか。\r\r・場所：#{@chosen_plan.location_broad}\r・時間：#{@chosen_plan.minute}分\r・金額：#{@chosen_plan.price_yen.to_s(:delimited)}円\r・第一希望日時：●月●日（●）●●：●●開始\r・第二希望日時：●月●日（●）●●：●●開始\r・第三希望日時：●月●日（●）●●：●●開始"
    end
  end

  def create
    receiver = User.find(params[:receive_user_id])
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
    params.require(:message).permit(:content)
  end
  
end
