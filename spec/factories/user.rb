FactoryBot.define do
  factory :user do
    email { '123@example.com' }
    password { '123456' }
  end
  
  trait :user2 do
    email { 'amoeric@example.com' }
  end

  trait :admin do
    email { 'admin@example.com' }
    role { 1 }
  end
end
  
