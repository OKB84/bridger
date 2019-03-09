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
  
  has_many :interested_instruments, dependent: :destroy
  has_many :instruments, through: :interested_instruments, dependent: :destroy
  accepts_nested_attributes_for :interested_instruments, allow_destroy: true
  
  has_many :interested_subjects, dependent: :destroy
  has_many :subjects, through: :interested_subjects, dependent: :destroy
  accepts_nested_attributes_for :interested_subjects, allow_destroy: true
  
  has_many :users_languages, dependent: :destroy
  has_many :languages, through: :users_languages, dependent: :destroy
  accepts_nested_attributes_for :users_languages, allow_destroy: true
  
  validates :languages, presence: true
end
