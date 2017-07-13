PASSWORD = 'supersecret'
User.destroy_all
User.create first_name: 'Jon', last_name:' Snow', email:'yoyo@hotmail.com', password: PASSWORD


10.times do
  first_name =  Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(
    first_name: first_name
    last_name: last_name
    email: "#{first_name.downcase}-#{last_name.downcase}@example.com",
    password: PASSWORD
  )
end


100.times do
  Question.create title: Faker::ChuckNorris.fact,
                  body: Faker::Hacker.say_something_smart,
                  view_count: rand(1000)
                  user: users.sample   #will pick one random user from the record
end

puts Cowsay.say('created 100 questions', :cow)
