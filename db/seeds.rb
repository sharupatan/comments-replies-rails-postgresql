# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Fake data of the user_followers table
users = [[1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7], [2, 1], [2, 3], [2, 4], [2, 5]]
UserFollower.destroy_all
for user in users
    UserFollower.create(followers_id: user[0], following_id: user[1])
end
