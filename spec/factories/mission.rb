FactoryBot.define do
  factory :mission do
    title { '18person' }
    content { '5xruby' }
    start_time { '2020-04-19 10:30' }
    end_time { '2020-04-19 11:30' }
  end
    
  trait :mission2 do
    title { '18person' }
    content { 'ericisme' }
    status { 2 }
    priority { 0 }
  end

  trait :mission3 do
    title { 'hellomission' }
    content { '5xruby' }
    status { 2 }
    priority { 2 }
  end
end