class PointHistoriesController < ApplicationController
  require 'payjp'

  def index
    @point_histories = PointHistory.where("(from_user_id = ?) OR (to_user_id = ?)", current_user.id, current_user.id).order(created_at: 'DESC')
    @points = current_user.points.order(created_at: 'DESC')
  end

  def new
    @lesson = Lesson.find_by(instructor_id: params[:to_user_id])
  end

  def create
    try = 0
    begin
      PointHistory.transaction do
        try += 1
        PointHistory.create!(from_user_id: current_user.id, to_user_id: params[:to_user_id], amount: params[:point])
        
        send_sum1 = PointHistory.where(from_user_id: current_user.id).sum(:amount)
        receive_sum1 = PointHistory.where(to_user_id: current_user.id).sum(:amount)
        current_point1 = receive_sum1 - send_sum1
        Point.create!(user_id: current_user.id, current_point: current_point1)
        
        to_user = User.find(params[:to_user_id])
        send_sum2 = PointHistory.where(from_user_id: to_user.id).sum(:amount)
        receive_sum2 = PointHistory.where(to_user_id: to_user.id).sum(:amount)
        current_point2 = receive_sum2 - send_sum2
        Point.create!(user_id: to_user.id, current_point: current_point2)
      end
      flash[:success] = 'ポイント支払いが完了しました'
    rescue => e
      retry if try < 10
      logger.error('')
      flash[:danger] = '保有ポイントが不足しています'
    end
    redirect_to current_user
  end
  
  def purchase
    try = 0
    begin
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      charge = Payjp::Charge.create(        
        :amount => params['price'],          #レッスンプランごとに変更したいがnumber_fieldから数値を受け取れなかった
        :card => params['payjp-token'],
        :currency => 'jpy',
      )
    rescue
      #エラー内容ごとにエラー表示を出せるようにする。API参照
      redirect_to current_user and return
    end
    
    begin
      PointHistory.transaction do
        try += 1
        PointHistory.create!(from_user_id: nil, to_user_id: current_user.id, amount: params[:price])
        
        send_sum = PointHistory.where(from_user_id: current_user.id).sum(:amount)
        receive_sum = PointHistory.where(to_user_id: current_user.id).sum(:amount)
        current_point = receive_sum - send_sum
        
        Point.create!(user_id: current_user.id, current_point: current_point)
      end
      flash[:success] = 'ポイントを購入しました'
    rescue => e
      retry if try < 10
      logger.error('purchased but not charged')
      flash.now[:danger] = 'ポイントを購入できませんでした'
    end
    redirect_to current_user and return
  end
end
