FactoryBot.define do
    factory :task do
        name {'test task'}
        contect {'test text'}
        status {0}
        deadline {'2020-04-06T13:21:01.107+09:00'}
        priority {2}
    end
end