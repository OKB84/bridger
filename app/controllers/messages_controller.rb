class MessagesController < ApplicationController
  def index
    @sended_messages = current_user.messages.order(created_at: 'DESC')
    @received_messages = current_user.reverses_of_message.order(created_at: 'DESC')
  end

  def show
    @message = Message.find(params[:id])
    unless @message.send_user == current_user || @message.receive_user == current_user
      redirect_to messages_path
    end
  end

  def new
    @message = Message.new
    @receive_user = User.find(params[:receive_user_id])
    if params[:reply_message_id]
      @reply_message = Message.find(params[:reply_message_id])
      @default_message = "\r\r---------- original message ----------\rFrom: #{@reply_message.send_user.name}\rSent: #{@reply_message.created_at.getlocal("+09:00").strftime("%-m/%-d(#{%w(日 月 火 水 木 金 土)[@reply_message.created_at.getlocal("+09:00").wday]}) %H:%M")}\r\r#{@reply_message.content}"
    elsif params[:type] == 'advertise'
      @default_message =
      "はじめまして。\r#{current_user.name}と申します。\r\r#{@receive_user.name}さんの使用楽器や興味を持たれている分野を拝見し、是非一度レッスン受講を検討していただきたくご連絡いたしました。\r\r以下を対象としたレッスンを実施していますので、差出人欄のリンクからレッスン情報をご覧いただけたらと思います。\r\r楽器：#{current_user.lesson.instruments.pluck(:ins_name_ja).join('、')}\r分野：#{current_user.lesson.subjects.pluck(:subj_name_ja).join('、')}\r\r\rどうぞよろしくお願いいたします。"
    elsif !(@receive_user.lesson.present?) || @receive_user == current_user
      redirect_to messages_url
    end
    @chosen_plan = LessonPlan.find_by(id: params[:plan_id])
    if @chosen_plan
      @default_message = 
      "#{@receive_user.name} さん、はじめまして。\r#{current_user.name} と申します。\r\r以下の内容でレッスンを受講させていただきたいのですが、ご都合はいかがでしょうか。\r\r・場所：#{@chosen_plan.location_broad}\r・時間：#{@chosen_plan.minute}分\r・金額：#{@chosen_plan.price_yen.to_s(:delimited)}円\r・第一希望日時：●月●日（●）●●：●●開始\r・第二希望日時：●月●日（●）●●：●●開始\r・第三希望日時：●月●日（●）●●：●●開始"
    end
  end

  def create
    receiver = User.find(params[:receive_user_id])
    content = message_params[:content]
    @message = Message.new(send_user: current_user, receive_user: receiver, content: content)
    if @message.save
      flash[:success] = 'メッセージを送信しました'
      redirect_to messages_url
      UserMailer.get_message_email(current_user, receiver).deliver
    else
      flash.now[:danger] = 'メッセージの送信に失敗しました'
      @receive_user = receiver
      render :new
    end
  end
  
  private
  
  def message_params
    params.require(:message).permit(:content, :reply_message, :type)
  end
  
end
