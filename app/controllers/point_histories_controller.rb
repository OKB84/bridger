class PointHistoriesController < ApplicationController
  require 'payjp' #requireをする場所はここでいいのか？

  def index
  end

  def new
  end

  def create
  end
  
  def purchase
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    charge = Payjp::Charge.create(        
      :amount => params[:price],          #レッスンプランごとに変更したいがnumber_fieldから数値を受け取れなかった
      :card => params['payjp-token'],
      :currency => 'jpy',
    )
    
    try = 0
  
    PointHistory.transaction do
      try += 1
      PointHistory.create(user_id: nil, other_user_id: current_user.id, amount: params[:price])
      
      send_sum = PointHistory.where(user_id: current_user.id).sum(:amount)
      receive_sum = PointHistory.where(other_user_id: current_user.id).sum(:amount)
      current_point = receive_sum - send_sum
      
      Point.create(user_id: current_user.id, current_point: current_point)
    end
      flash[:success] = 'ポイントを購入しました'
      redirect_to current_user
    rescue => e
      retry if try < 100
      logger.error('purchased but not charged')
      flash.now[:danger] = 'ポイントを購入できませんでした'
      redirect_to current_user
  end
end
