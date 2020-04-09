FactoryBot.define do
    factory :user do
        name {'test user'}
        sequence(:name) { |i| "user#{i}" }
        sequence(:email) { |i| "user#{i}@example.com" }
        password {'password'}
    end
end