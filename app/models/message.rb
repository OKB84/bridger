class Message < ApplicationRecord
  belongs_to :send_user, class_name: 'User'
  belongs_to :receive_user, class_name: 'User'
  
  validates :send_user, presence: true
  validates :receive_user, presence: true
  validates :content, presence: true
end
