class Label < ApplicationRecord
    validates :name, presence: true, length: {maximum: 30}

    has_many :relation_task_labels, dependent: :destroy
    has_many :tasks, through: :relation_task_labels
end
