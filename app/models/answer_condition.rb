class AnswerCondition < ApplicationRecord
  belongs_to :question
  belongs_to :question_answer

  def self.sql_format(id)
    @sql = ""
    @conditions = self.where(question_answer_id: id)
    @conditions.each do |c|
      @sql << "(survey_answers.question_id = #{c.question_id} AND survey_answers.value #{c.method} #{c.value})"
      if c.relation != nil
        @sql << " #{c.relation.upcase} "
      end
    end
    return @sql
  end

  def self.query_condition(id, session)
    @array = []
    @meet_condition = []
    @conditions = self.where(question_answer_id: id)
    @conditions.order(row: :asc).each do |c|
      @sql = "survey_answers.question_id = #{c.question_id} AND survey_answers.value #{c.method} '#{c.value}' AND survey_answers.session = '#{session}'"
        @answer = SurveyAnswer.where(@sql).first
        if @answer.present?
          @array << true
        else
          @array << false
        end
    end

    # Loop again to compare between conditions
    @conditions.order(row: :asc).each_with_index do |c, i|
      if c.relation == 'and'
        if @array[i] && @array[i + 1]
         @meet_condition << true 
        else
          @meet_condition << false
        end
      elsif c.relation == 'or'
        if @array[i] || @array[i + 1]
          @meet_condition << true 
        else
          @meet_condition << false
        end
      else
        if @array[0] == true
          @meet_condition << true
        end
      end
    end

   @strip_condition = @meet_condition.uniq
   Rails.logger.info "TESTTT #{@strip_condition}"
   if @conditions.present?
    if @strip_condition.length == 1 && @strip_condition[0] == true
      return true
    else
      return false
    end
  else
    return true
  end
  end
end
