class Language < ApplicationRecord
  has_many :users_languages, dependent: :destroy
  has_many :users, through: :users_languages, dependent: :destroy
end
