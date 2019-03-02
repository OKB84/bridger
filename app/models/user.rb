class User < ApplicationRecord
  authenticates_with_sorcery!
  
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  
  has_many :messages, foreign_key: 'send_user_id'
  has_many :receivers, through: :messages, source: :receive_user
  # has_many :sended_messages, through: :messages, source: :content
  has_many :reverses_of_message, class_name: 'Message', foreign_key: 'receive_user_id'
  has_many :senders, through: :reverses_of_message, source: :send_user
  # has_many :received_messages, through: :reverses_of_message, source: :content
  
  # def send(receive_user, content)
  #   unless self == receive_user
  #     self.messages.create(send_user_id: self.id, receive_user_id: receive_user.id, content: content)
  #   end
  # end
  
end
