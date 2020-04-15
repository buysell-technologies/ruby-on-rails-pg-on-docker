FactoryBot.define do
    factory :user do
        sequence(:name){|n| "user#{n}"}
        sequence(:email){|n| "example#{n}@sample.com"}
        password {'password'}
    end
end