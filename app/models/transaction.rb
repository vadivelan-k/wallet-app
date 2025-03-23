class Transaction < ApplicationRecord
  belongs_to :wallet
  belongs_to :sender, class_name: 'User', foreign_key: :sender_id

  TRANSACTION_TYPES = %w[credit debit transfer].freeze

  validates_presence_of :transaction_type, :sender_id, :amount, :status
  validates_inclusion_of :transaction_type, in: TRANSACTION_TYPES
end
