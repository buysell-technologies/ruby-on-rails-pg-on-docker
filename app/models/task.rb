class Task < ApplicationRecord
    validates :title, length: { minimum: 1, maximum: 20 }
    validates :description, presence: true
end
