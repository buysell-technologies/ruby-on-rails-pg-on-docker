# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
(1..100).each do |i|
    Task.create(name: "test title " + i.to_s,
                content: "test content text" + i.to_s,
                label: "test label",
                status: 0,
                deadline: Time.zone.now.tomorrow,
                priority: 2
                )
end