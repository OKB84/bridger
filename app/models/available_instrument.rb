class AvailableInstrument < ApplicationRecord
  belongs_to :lesson
  belongs_to :instrument
end
