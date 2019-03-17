class Point < ApplicationRecord
  belongs_to :user
  
  validates :current_point, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
