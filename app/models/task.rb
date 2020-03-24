class Task < ApplicationRecord
    validates :title, length: { minimum: 1, maximum: 30 }
    validates :description, presence: true
    validates :deadline_date, presence: true
    enum status: {未着手: 0, 作業中: 1, 完了: 2}

    belongs_to :user

    ransacker :keywords do |tasks|
        Arel::Nodes::InfixOperation.new('||', tasks.table[:title], tasks.table[:description])
      end
end
