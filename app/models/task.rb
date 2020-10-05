class Task < ApplicationRecord
    validates :title, presence: true, length: {maximum:20}
    validates :text, length: {maximum:50}
    
    enum status: {
        yet: 0,
        doing: 1,
        complete: 2
    }
end
