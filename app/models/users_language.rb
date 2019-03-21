class UsersLanguage < ApplicationRecord
  belongs_to :user
  belongs_to :language
  
  # validates :user, presence: true　これを入れるとUserの新規登録時にuser_idが未定の状態でusers_languageレコードを登録しないといけないため、エラーになってしまう。
  validates :language, presence: true
end
