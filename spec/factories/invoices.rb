FactoryBot.define do
  factory :invoice do
    # customer { nil }
    # merchant { nil }
    status { "shipped" }
    association :customer, factory: :customer
    association :merchant, factory: :merchant
  end
end
