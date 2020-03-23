FactoryBot.define do
  factory :invoice_item do
    # item { nil }
    # invoice { nil }
    quantity { ((Faker::Number.within(range: 1..20))) }
    unit_price { Faker::Commerce.price(range: 0.1..100.0, as_string: false) }
    association :item, factory: :item
    association :invoice, factory: :invoice
  end
end
