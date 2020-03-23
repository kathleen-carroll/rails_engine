FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Bank.account_number(digits: 14) }
    credit_card_expiration_date { "2020-03-18" }
    result { "success" }
    association :invoice, factory: :invoice
  end
end
