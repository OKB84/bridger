class PointHistory < ApplicationRecord
  belongs_to :user
  belongs_to :other_user, class_name: 'User'
  
  validates :amount, presence: true, numericality: { only_integer: true }
end
