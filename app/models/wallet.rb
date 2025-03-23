class Wallet < ApplicationRecord
  has_many :transactions
  belongs_to :user

  validates_presence_of :wallet_type

  def deposit(amount:, sender_id:, receiver_id: nil)
    transaction = transactions.build(
      transaction_type: 'credit', amount: amount, sender_id: sender_id, receiver_id: receiver_id
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

  def withdraw(amount:, sender_id:, receiver_id: nil)
    raise CustomExceptions::NotEnoughBalance if available_balance < amount

    transaction = transactions.build(
      transaction_type: 'debit', amount: amount, sender_id: sender_id, receiver_id: receiver_id
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
      withdraw(amount: amount, sender_id: sender_id, receiver_id: receiver.id)
      receiver.wallet.deposit(amount: amount, sender_id: sender_id, receiver_id: receiver.id)
    end
  end
end
