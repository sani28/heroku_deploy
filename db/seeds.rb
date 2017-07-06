100.times do
  Question.create title: Faker::ChuckNorris.fact,
                  body: Faker::Hacker.say_something_smart,
                  view_count: rand(1000)

end

puts Cowsay.say('created 100 questions', :cow)
