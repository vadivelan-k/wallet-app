FactoryBot.define do
  factory :transaction do
    transaction_type { 'credit' }
    amount { 100.0 }
    status { 'completed' }

    wallet
    perform_by { association :user }
  end
end
