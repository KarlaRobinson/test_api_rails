FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    category { Faker::Commerce.department }
  end
end