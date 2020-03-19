FactoryBot.define do
  factory :task do
    title { '掃除' }
    description { '家の掃除をする' }
    deadline_date { '2020-03-03' }
    status { '完了' }
    created_at { Time.now }
  end
end