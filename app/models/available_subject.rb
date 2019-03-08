class AvailableSubject < ApplicationRecord
  belongs_to :lesson
  belongs_to :subject
end
