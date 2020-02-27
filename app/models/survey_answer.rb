class SurveyAnswer < ApplicationRecord
  require 'csv'
  belongs_to :survey
  belongs_to :question

  def question
    return Question.where(id: question_id).first.description #-> returns first instance of `OtherModel` & then displays "name"
 end

  def self.to_csv
    attributes = %w{session created_at question value time_per_question}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |submission|
        csv << attributes.map{ |attr| submission.send(attr) }
      end
    end
  end



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
