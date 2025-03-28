FactoryBot.define do
  factory :user do
    name  { Faker::Name.name }
    email { Faker::Internet.email }
    phone { Faker::Base.numerify('8#######') }
  end
end
