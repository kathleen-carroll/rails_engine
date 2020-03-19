FactoryBot.define do
  factory :item do
    name { Faker::Hipster.word.capitalize }
    description { Faker::Hipster.sentence }
    unit_price { Faker::Commerce.price(range: 0.1..100.0, as_string: false) }
    association :merchant, factory: :merchant
  end
end
