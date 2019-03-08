class Subject < ApplicationRecord
  has_many :interested_instruments, dependent: :destroy
  has_many :users, through: :interested_instruments, dependent: :destroy
  
  has_many :available_subjects, dependent: :destroy
  has_many :lessons, through: :available_subjects, dependent: :destroy
end
