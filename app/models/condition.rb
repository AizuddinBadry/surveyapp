class Condition < ApplicationRecord
    belongs_to :question
    has_one :condition_link, dependent: :destroy
end
