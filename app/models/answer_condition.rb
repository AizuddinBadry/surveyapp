class AnswerCondition < ApplicationRecord
  belongs_to :question
  belongs_to :question_answer
end
