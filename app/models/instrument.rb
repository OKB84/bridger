class Instrument < ApplicationRecord
  has_many :interested_instruments, dependent: :destroy
  has_many :users, through: :interested_instruments, dependent: :destroy
  
  has_many :available_instruments, dependent: :destroy
  has_many :lessons, through: :available_instruments, dependent: :destroy
end
