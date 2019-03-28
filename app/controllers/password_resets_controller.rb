class PasswordResetsController < ApplicationController
  skip_before_filter :require_login
  
  def new
  end
  
  def create
    @user = User.find_by_email(params[:email])
        
    # This line sends an email to the user with instructions on how to reset their password (a url with a random token)
    @user.deliver_reset_password_instructions! if @user
        
    # Tell the user instructions have been sent whether or not email was found.
    # This is to not leak information to attackers about which emails exist in the system.
    flash[:success] = 'パスワードの再設定メールが送信されました'
    redirect_to root_url
  end

  def edit
    set_token_user_from_params?
  end

  def update
    return if !set_token_user_from_params?
 
    @user.password_confirmation = params[:user][:password_confirmation]
 
    if @user.change_password!(params[:user][:password])
      flash[:success] = 'パスワードのリセットが完了しました'
      redirect_to root_url
    else
      render :action => "edit"
    end
  end
  
  private
 
    def set_token_user_from_params?
      @token = params[:id]
      @user = User.load_from_reset_password_token(params[:id])
 
      if @user.blank?
        not_authenticated
        return false
      else
        return true
      end
    end
end
