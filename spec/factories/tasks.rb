# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title { 'Test tilte' }
    text { 'Test text' }
  end
end
