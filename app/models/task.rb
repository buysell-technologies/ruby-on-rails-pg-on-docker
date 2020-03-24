class Task < ApplicationRecord
    validates :title, length: { minimum: 1, maximum: 30 }
    validates :description, presence: true
    enum status: {todo: 0, doing: 1, done: 2}

    ransacker :keywords do |tasks|
        Arel::Nodes::InfixOperation.new('||', tasks.table[:title], tasks.table[:description])
      end
end
