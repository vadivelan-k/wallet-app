FactoryBot.define do
  factory :wallet do
    available_balance { 100.0 }
    actual_balance { 100.0 }
    wallet_type { Wallet::DEFAULT_WALLET_TYPE }

    user
  end
end
