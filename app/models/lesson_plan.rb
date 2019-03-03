class LessonPlan < ApplicationRecord
  belongs_to :lesson
  
  validates :minute, presence: true
  validates :location_broad, presence: true, length: { maximum: 255}
  validates :location_narrow, length: { maximum: 255 }
  validates :price_yen, presence: true
end
