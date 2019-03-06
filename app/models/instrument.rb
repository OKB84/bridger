class Instrument < ApplicationRecord
  has_many :interested_instruments
  has_many :users, through: :interested_instruments
end
