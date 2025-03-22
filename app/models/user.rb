class User < ApplicationRecord
  has_one :wallet
  has_many :user_transactions, class_name: 'Transaction', foreign_key: :sender_id

  validates_presence_of :name, :email, :phone
end
