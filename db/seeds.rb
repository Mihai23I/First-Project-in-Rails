User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "Mihai",
            email: "admin@gmail.com",
            password:              "123456",
            password_confirmation: "123456",
            admin:     true,
            activated: true,
            activated_at: Time.zone.now)

#english
99.times do
  name  = Faker::WorldOfWarcraft.hero
  email = Faker::Internet.email
  password = "password"
  User.create!(name:  name,
              email: email,
              password:              password,
              password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now)
end

def quote
  message = case rand(1..5)
            when 1 then Faker::Overwatch.quote
            when 2 then Faker::GameOfThrones.quote
            when 3 then Faker::LeagueOfLegends.quote
            when 4 then Faker::ChuckNorris.fact
            when 5 then Faker::WorldOfWarcraft.quote
            end
  message = Faker::Name.name if message.length > 140
  message
end

users = User.order(:created_at).take(30)
users.each do |user|
  rand(1..50).times do
    content = quote
    user.microposts.create!(content: content)
  end
end

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
