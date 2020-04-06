# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

(1..10).each do |i|
    User.create(name: 'User '+i.to_s, 
                email: 'test'+i.to_s+'@test.ac.jp', 
                password: 'pass'
                )

    (1..10).each do |j|
        Task.create(name: "test title " + j.to_s,
                    content: "test content text" + j.to_s,
                    status: 0,
                    deadline: Time.zone.now.tomorrow,
                    priority: 2,
                    user_id: i.to_s
                    )
    end
end

Label.create(name: "work")
Label.create(name: "private")
Label.create(name: "family")