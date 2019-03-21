class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  
  def new
    if logged_in?
      redirect_back_or_to current_user
    end
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password])
    
    if @user
      flash[:success] = 'ログインに成功しました'
      redirect_back_or_to(user_path(@user))
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render action: 'new'
    end
  end

  def destroy
    logout
    flash[:success] = 'ログアウトしました'
    redirect_to login_url
  end
end
