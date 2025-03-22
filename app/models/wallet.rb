class Wallet < ApplicationRecord
  has_many :transactions
  belongs_to :user

  validates_presence_of :wallet_type
end
