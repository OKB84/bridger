class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.activation_needed_email.subject
  #
  def activation_needed_email(user)
    @user = user
    @url  = "https://desolate-taiga-73453.herokuapp.com/users/#{user.activation_token}/activate"
    mail(:to => user.email,
         :subject => "【Bridger】アカウント登録確認")
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.activation_success_email.subject
  #
  def activation_success_email(user)
    @user = user
    @url  = "https://desolate-taiga-73453.herokuapp.com/lessons/new"
    mail(:to => user.email,
         :subject => "【Bridger】アカウント登録完了")
  end
  
  def reset_password_email(user)
    @user = User.find user.id
    @url = edit_password_reset_url(@user.reset_password_token)
    mail(:to => user.email,  :subject => "【Bridger】パスワード再設定メール")
  end
  
  def get_message_email(send_user, receive_user)
    @send_user = send_user
    @receive_user = receive_user
    @url = "https://desolate-taiga-73453.herokuapp.com/messages"
    mail(:to => receive_user.email,
         :subject => "【Bridger】 #{@send_user.name}さんからメッセージが届いています")
  end
end
