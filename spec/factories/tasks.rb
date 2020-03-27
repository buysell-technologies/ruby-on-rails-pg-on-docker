FactoryBot.define do
  factory :task, class: Task do
    id { 1 }
    title { '掃除' }
    description { '家の掃除をする' }
    deadline_date { '2020-03-03' }
    status { '完了' }
    created_at { '2020-03-03' }
    updated_at { '2020-03-03' }
  end
  
  factory :second_task, class: Task do
    id { 2 }
    title { '勉強' }
    description { 'テスト' }
    deadline_date { '2020-04-04' }
    status { '未着手' }
    created_at { '2020-04-04' }
    updated_at { '2020-04-04' }
  end
end