FactoryBot.define do
  factory :merchant do
    name { Faker::Hipster.word.capitalize }
  end
end
