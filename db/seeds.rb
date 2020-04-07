# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Label.create(name: "label a")
Label.create(name: "label b")
Label.create(name: "label c")

(1..10).each do |i|
    User.create(name: 'User '+i.to_s, 
                email: 'test'+i.to_s+'@test.ac.jp', 
                password: 'pass'
                )

    (1..10).each do |j|
        @task = Task.create(name: "test title " + j.to_s,
                    content: "test content text" + j.to_s,
                    status: 0,
                    deadline: Time.zone.now.tomorrow,
                    priority: 2,
                    user_id: i.to_s
                    )
        labels = Label.all.sample(2)
        @task.add_label(labels[0])
        @task.add_label(labels[1])
    end
end