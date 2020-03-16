class Task < ApplicationRecord
    validates :title, length: { minimum: 1, maximum: 30 }
    validates :description, presence: true
end
