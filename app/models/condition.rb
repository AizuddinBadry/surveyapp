class Condition < ApplicationRecord


    belongs_to :question, class_name: "Question", foreign_key: "condition_question_id"

end
