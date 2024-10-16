FactoryBot.define do
  factory :post do
    title { Faker::Book.title }
    description { Faker::Lorem.paragraph }
  end
end
