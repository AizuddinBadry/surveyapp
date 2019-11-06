module Questions
    class ConditionCheck
        def initialize(question_id, answer, survey_id)
            @response = ''
            @question = Question.find_by_id(question_id)
            if answer.kind_of?(Array)
                answer.each do |a|
                    @c_a = a.to_i
                    @condition = Condition.where(question_id: question_id, value: @c_a).first
                    @next_question = Question.find_by_id(@condition.condition_question_id) unless @condition.nil? || @condition.condition_question_id == 0
                end
            else
                @condition = Condition.where(question_id: question_id, value: answer).first
                @next_question = Question.find_by_id(@condition.condition_question_id) unless @condition.nil? || @condition.condition_question_id == 0
            end
            @question = Question.where(survey_id: survey_id, survey_position: @next_question.survey_position).first unless @next_question.nil?

            if @condition.nil?
                @response = 'end'
            elsif @condition.condition_question_id == 0
                @response = false
            else
                @response = @question
            end

            Rails.logger.info "RESPONSE #{@response}"

            return @response
        end
    end
end