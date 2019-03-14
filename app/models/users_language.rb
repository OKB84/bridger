class UsersLanguage < ApplicationRecord
  belongs_to :user
  belongs_to :language
  
  validates :user, presence: true
  validates :language, presence: true
end
