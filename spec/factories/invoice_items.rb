FactoryBot.define do
  factory :invoice_item do
    item { nil }
    invoice { nil }
    quantity { "MyString" }
    unit_price { 1.5 }
  end
end
