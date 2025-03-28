class Wallet < ApplicationRecord
  has_many :transactions
  belongs_to :user

  DEFAULT_WALLET_TYPE = 'credit_card'.freeze

  validates_presence_of :wallet_type

  def deposit(amount:, perform_by_id:, receiver_id: nil)
    transaction = transactions.build(
      transaction_type: 'credit', amount: amount, perform_by_id: perform_by_id, receiver_id: receiver_id
    )

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

  def withdraw(amount:, perform_by_id:, receiver_id: nil)
    raise CustomExceptions::NotEnoughBalance if available_balance < amount

    transaction = transactions.build(
      transaction_type: 'debit', amount: amount, perform_by_id: perform_by_id, receiver_id: receiver_id
    )

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

  def transfer_money(amount:, sender_id:, receiver:)
    ActiveRecord::Base.transaction do
      withdraw(amount: amount, perform_by_id: sender_id, receiver_id: receiver.id)
      receiver.wallet.deposit(amount: amount, perform_by_id: sender_id, receiver_id: receiver.id)
    end
  end
end
