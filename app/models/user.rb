class User < ApplicationRecord
  authenticates_with_sorcery!
  
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  
  has_many :messages, foreign_key: 'send_user_id', dependent: :destroy
  has_many :receivers, through: :messages, source: :receive_user, dependent: :destroy
  has_many :reverses_of_message, class_name: 'Message', foreign_key: 'receive_user_id', dependent: :destroy
  has_many :senders, through: :reverses_of_message, source: :send_user, dependent: :destroy

  has_one :lesson, foreign_key: 'instructor_id', dependent: :destroy
  
end
