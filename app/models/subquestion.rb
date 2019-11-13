class Subquestion < ApplicationRecord
  belongs_to :question


  def default_values
    size = Subquestion.where(question_id: self.question_id).size
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
  
end
