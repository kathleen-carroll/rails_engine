FactoryBot.define do
  factory :transaction do
    invoice { nil }
    credit_card_number { "MyString" }
    credit_card_expiration_date { "2020-03-18 00:07:51" }
    result { "MyString" }
  end
end
