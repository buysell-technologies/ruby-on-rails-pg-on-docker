class Task < ApplicationRecord
    # 空文字とStringが255までだからそれ以上は除去
    validates :name, presence: true, length: {maximum: 255}
    # 空文字を許し最大400文字としておく
    validates :content, length: {maximum: 400}
    # statusは0~2の整数
    validates :status, presence: true, numericality: {only_integer: true, less_than: 3}
    # priorityは0~4の整数
    validates :priority,  presence: true, numericality: {only_integer: true, less_than: 5}
end
