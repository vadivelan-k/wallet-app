class Transaction < ApplicationRecord
  belongs_to :wallet
  belongs_to :perform_by, class_name: 'User', foreign_key: :perform_by_id

  TRANSACTION_TYPES = %w[credit debit].freeze

  validates_presence_of :transaction_type, :amount, :status
  validates_inclusion_of :transaction_type, in: TRANSACTION_TYPES
  validates_numericality_of :amount, greater_than: 0

  def mark_as_completed
    self.status = 'completed'
  end
end
