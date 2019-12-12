class QuestionAnswer < ApplicationRecord
  before_save :default_values

  def default_values
    size = QuestionAnswer.where(question_id: self.question_id).size
    self.position ||= size + 1
  end

  def self.query_language(answer, lang)
    
    @answer = answer.other_language["#{lang}"]
    if @answer == false
      return nil
    else
      return @answer
    end
  end

  belongs_to :question, optional: true
  has_one :answer_condition
  #acts_as_list scope: :question
end
