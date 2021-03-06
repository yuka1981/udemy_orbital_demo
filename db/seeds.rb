# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create admin test user
User.create!(name: 'Test User', email: 'test@testuser.com', password: 'password123', password_confirmation: 'password123', admin: true)

# Bulk generate test users
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@testuser.org"
  password = 'password123'
  User.create!(name: name, email: email, password: password, password_confirmation: password)
end

users = User.order(:created_at).take(5)
40.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.snapshots.create!(content: content) }
end
