class PointHistory < ApplicationRecord
  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'
  
  validates :amount, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :validate_send_amount_for_balance
  
  private
  
  def validate_send_amount_for_balance
    if self.from_user.present?
      balance = self.from_user.points.last.current_point
      if self.amount > balance
        flash.now[:danger] = 'ポイントが足りません'
        redirect_to current_user
      end
    end
  end
end
