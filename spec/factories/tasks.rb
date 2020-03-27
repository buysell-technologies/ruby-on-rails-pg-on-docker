FactoryBot.define do
  factory :task do
    title { '掃除' }
    description { '家の掃除をする' }
    created_at { Time.now }
  end
end