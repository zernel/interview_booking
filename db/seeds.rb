# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


%W(A B C D).each do |i|
  Investor.create(name: "合伙人 #{i}")
end

20.times do |i|
  User.create(name: "创业者 ##{i+1}")
end
