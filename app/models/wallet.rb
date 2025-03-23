class Wallet < ApplicationRecord
  has_many :transactions
  belongs_to :user

  validates_presence_of :wallet_type

  def deposit(amount:, sender:)
    transaction = transactions.build(transaction_type: 'credit', amount: amount, sender_id: sender)

    transaction.transaction do
      transaction.mark_as_completed
      transaction.save!

      update_columns(
        available_balance: available_balance + amount,
        actual_balance: actual_balance + amount,
        )
    end

    transaction
  end

  def withdraw(amount:, sender:)
    transaction = transactions.build(transaction_type: 'debit', amount: amount, sender_id: sender)

    transaction.transaction do
      transaction.mark_as_completed
      transaction.save!

      update_columns(
        available_balance: available_balance - amount,
        actual_balance: actual_balance - amount,
      )
    end

    transaction
  end
end
