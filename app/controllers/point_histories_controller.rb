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
    charge = Payjp::Charge.create(        #一旦newをしてif saveとした方がよい？chargeは何につかう変数なのか
      :amount => params[:price],          #レッスンプランごとに変更
      :card => params['payjp-token'],
      :currency => 'jpy',
    )
    Point.create(user_id: current_user.id, current_point: params[:price])
    flash[:success] = 'ポイント購入が完了しました'
    redirect_to points_url
  end
end
