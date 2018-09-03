FactoryBot.define do
  factory :charge do
    amount { Faker::Number.number(10) }
    payment_type { ['card', 'oxxo', 'spei'].sample }
  end
end