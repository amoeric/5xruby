FactoryBot.define do
    factory :user do
      title { Faker::Name.name }
      price { Faker::Number.between(1, 20) }
      description { Faker::Lorem.paragraphs }
      is_available { Faker::Boolean.boolean }
    end
  
    trait :ruby do #特徵
      title { "ruby" }
    end
  
    trait :free do
      price { 0 }
    end
  end
  
