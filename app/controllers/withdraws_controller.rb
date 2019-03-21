class WithdrawsController < ApplicationController
  def new
    @user = current_user
    unless @user.bank.present? && @user.branch.present? && @user.account_type.present? && @user.account_number.present? && @user.account_holder.present?
      flash[:warning] = '口座情報を入力してください'
      redirect_to edit_user_url(current_user)
    end
  end

  def create
    if params[:point].to_i >= 5000
      try = 0
      begin
        PointHistory.transaction do
          try += 1
          PointHistory.create!(from_user_id: current_user.id, to_user_id: nil, amount: params[:point])
          
          send_sum1 = PointHistory.where(from_user_id: current_user.id).sum(:amount)
          receive_sum1 = PointHistory.where(to_user_id: current_user.id).sum(:amount)
          current_point1 = receive_sum1 - send_sum1
          Point.create!(user_id: current_user.id, current_point: current_point1)
        end
        flash[:success] = 'ポイント出金依頼が完了しました'
        redirect_to current_user
      rescue => e
        retry if try < 10
        flash.now[:danger] = '保有ポイントを超過しています'
        render :new
      end
    else
      flash.now[:warning] = '出金依頼は5000ポイント以上から受け付けています'
      render :new
    end
  end
end
