class Task < ApplicationRecord
    validates :title, length: { minimum: 1, maximum: 30 }
    validates :description, presence: true
    enum status: {未着手: 0, 作業中: 1, 完了: 2}

    ransacker :keywords do |tasks|
        Arel::Nodes::InfixOperation.new('||', tasks.table[:title], tasks.table[:description])
      end
end
