FactoryBot.define do
    sequence :name do |n|
        "user#{n}"
    end
    sequence :email do |n|
        "example#{n}@sample.com"
    end

    factory :user do
        name
        email
        password {'password'}
    end
end