class Todo < ApplicationRecord
    validates :task, presence: true
    validates :is_done, presence: false
end
