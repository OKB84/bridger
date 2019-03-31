class User < ApplicationRecord
  authenticates_with_sorcery!
  
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  
  validates :bank, length: { maximum: 255 }
  validates :branch, length: { maximum: 255 }
  validates :account_type, length: { maximum: 255 }
  validates :account_number, length: { maximum: 255 }
  validates :account_holder, length: { maximum: 255 }
  
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
  
  has_many :points, dependent: :destroy
  
  has_many :point_histories, foreign_key: 'from_user_id', dependent: :destroy
  has_many :point_receivers, through: :point_histories, source: :to_user, dependent: :destroy
  has_many :reverse_of_point_histories, class_name: 'PointHistory', foreign_key: 'to_user_id', dependent: :destroy
  has_many :point_senders, through: :reverse_of_point_histories, source: :from_user, dependent: :destroy
  
  has_many :reviews, foreign_key: 'from_user_id', dependent: :destroy
  has_many :reverse_of_reviews, through: :reviews, source: :to_user, dependent: :destroy
  has_many :rates, through: :reverse_of_reviews, source: :rate, dependent: :destroy
  has_many :comments, through: :reverse_of_reviews, source: :comment, dependent: :destroy
end
