class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login
  
  def counts(user)
    @count_favorited_users = user.favorited_users.count
  end
  
  private
  
  def not_authenticated
    flash[:warning] = 'ログインして下さい'
    redirect_to login_url
  end
end
