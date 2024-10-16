FactoryBot.define do
  factory :post do
    title { Faker::Books.title }
    description { Faker::Lorem.paragraph }
  end
end
