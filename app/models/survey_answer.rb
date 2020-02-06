class SurveyAnswer < ApplicationRecord
  belongs_to :survey
  belongs_to :question

  def self.check_mc(question_pos, survey_id, session, answer, time_per_question)
    @question = Question.find_by(survey_id: survey_id, survey_position: question_pos)
    @save_answer = SurveyAnswer.where(session: session, question_id: @question.id, survey_id: survey_id).first
    if @save_answer.value.include? answer.to_s
      return true
    else
      return false
    end unless @save_answer.nil? || @save_answer.value.nil?
  end

  def value
    @value = read_attribute(:value) 
    if @value == nil
      'No answer'
    else
      @value
    end
  end

  def self.total_response(id)
    self.joins(:survey).where(surveys: {user_id: id}).group_by(&:session).size
  end

end
