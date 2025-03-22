class Transaction < ApplicationRecord
  belongs_to :wallet
  belongs_to :sender, class_name: 'User', foreign_key: :sender_id

  validates_presence_of :transaction_type, :sender_id, :amount, :status
end
