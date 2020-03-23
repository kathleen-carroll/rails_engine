FactoryBot.define do
  factory :customer do
    first_name { Faker::Hipster.word.capitalize }
    last_name { Faker::Hipster.word.capitalize }
  end
end
