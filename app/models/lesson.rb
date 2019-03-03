class Lesson < ApplicationRecord
  belongs_to :instructor, class_name: 'User'

  validates :instructor_id, uniqueness: true
  validates :youtube_url1, format: /\A#{URI::regexp(%w(http https))}\z/
  validates :youtube_url2, format: /\A#{URI::regexp(%w(http https))}\z/
  validates :youtube_url3, format: /\A#{URI::regexp(%w(http https))}\z/
  validates :biography, presence: true
  validates :advantage, presence: true

  has_many :lesson_plans, dependent: :destroy
  accepts_nested_attributes_for :lesson_plans, allow_destroy: true
end
