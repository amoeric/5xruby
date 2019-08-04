1.times{
  user = User.create( email: "xeriok02390@example.com", password: "123456" )
  30.times{
    p "------------------------"
    title = Faker::Artist.name
    content = Faker::Lorem.paragraph_by_chars(256, false)
    start_time = Faker::Time.between(2.days.ago, Date.today, :all)
    end_time = Faker::Time.between(1.days.ago, Date.today, :all)
    Mission.create(user_id: user.id, title: title, content: content, start_time: start_time, end_time: end_time, status: rand(0..2) )
  }
}

1.times{
  user = User.create( email: "123@example.com", password: "123456", role: 1 )
  50.times{
    p "------------------------"
    title = Faker::Artist.name
    content = Faker::Lorem.paragraph_by_chars(256, false)
    start_time = Faker::Time.between(2.days.ago, Date.today, :all)
    end_time = Faker::Time.between(1.days.ago, Date.today, :all)
    Mission.create(user_id: user.id, title: title, content: content, start_time: start_time, end_time: end_time, status: rand(0..2) )
  }
}