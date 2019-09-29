class QuestionAnswer < ApplicationRecord
  before_save :default_values

  def default_values
    size = QuestionAnswer.where(question_id: self.question_id).size
    self.position ||= size + 1
  end

  belongs_to :question
  #acts_as_list scope: :question
end
