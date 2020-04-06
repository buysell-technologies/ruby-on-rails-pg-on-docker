class Task < ApplicationRecord
    # 空文字とStringが255までだからそれ以上は除去
    validates :name, presence: true, length: {maximum: 255}
    # 空文字を許し最大400文字としておく
    validates :content, length: {maximum: 400}
    # statusは0~2の整数
    validates :status, presence: true, numericality: {only_integer: true, less_than: 3}
    # priorityは0~4の整数
    validates :priority,  presence: true, numericality: {only_integer: true, less_than: 5}

    has_many :relation_task_labels
    has_many :labels, through: :relation_task_labels

    belongs_to :user

    def add_label(label)
        # 同一ラベルが複数付与される事を防ぐ
        self.relation_task_labels.find_or_create_by(label_id: label.id)
    end

    def delete_label(label)
        relationtasklabel = self.relation_task_labels.find_by(label_id: label.id)
        relationtasklabel.destroy if relationship
    end

    # N+1問題対策
    def labeled?(label)
        self.labels.include?(label)
    end
end
