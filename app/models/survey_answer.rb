class SurveyAnswer < ApplicationRecord
  belongs_to :survey
  belongs_to :question

  def self.check_mc(question_pos, survey_id, session, answer, time_per_question)
    @question = Question.find_by(survey_id: survey_id, survey_position: question_pos)
    @save_answer = SurveyAnswer.where(session: session, question_id: @question.id, survey_id: survey_id).first
    Rails.logger.info "?????????????????????????????#{session}, #{@question.id}, #{survey_id}, #{answer}, #{time_per_question}"
    if @save_answer.value.include? answer.to_s
      return true
    else
      return false
    end unless @save_answer.nil? || @save_answer.value.nil?
  end
end
