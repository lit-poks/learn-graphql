FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.paragraph }
    post { Post.take || build(:post) }
  end
end
