class User < ApplicationRecord
  has_one :wallet
  has_many :user_transactions, class_name: 'Transaction', foreign_key: :sender_id

  validates_presence_of :name, :email, :phone

  after_create  :setup_wallet

  DEFAULT_WALLET_TYPE = 'credit_card'.freeze

  private
  def setup_wallet
    create_wallet(wallet_type: DEFAULT_WALLET_TYPE)
  end
end
