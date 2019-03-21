class WithdrawsController < ApplicationController
  def new
    @user = current_user
    unless @user.bank.present? && @user.branch.present? && @user.account_type.present? && @user.account_number.present? && @user.account_holder.present?
      flash[:warning] = '口座情報を入力してください'
      redirect_to edit_user_url(current_user)
    end
  end

  def create
  end
end
