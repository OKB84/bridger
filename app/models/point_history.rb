class PointHistory < ApplicationRecord
  belongs_to :user
  belongs_to :other_user, class_name: 'User'
  
  validates :amount, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :validate_send_amount_for_balance
  
  private
  
  def validate_send_amount_for_balance
    if self.user.present?
      balance = self.user.points.last.current_point
      if self.amount > balance
        flash.now[:danger] = 'ポイントが足りません'
        redirect_to current_user
      end
    end
  end
end
