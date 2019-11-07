module Questions
    class Submission
        @message = ''
        @question = ''
        @question_position = ''

        def self.submit(args = {})
            @message = ''
            @current_question_pos = args[:q1]
            @next_question_pos = args[:q2]
            @answer = args[:answer]
            @survey_id = args[:survey_id]
            
            @next_question = Questions::Submission.query_question(@next_question_pos, @survey_id) #Query next question for return data
            @current_question = Questions::Submission.query_question(@current_question_pos, @survey_id) #Query current question to check validation, logic, etc
            
            @question = @next_question
            @question_position = @next_question_pos
            if @current_question.mandatory == true
                @message = 'Please fill in the answer.' unless args[:answer].present?
                @question =  @current_question unless args[:answer].present?
                @question_position = @current_question_pos unless args[:answer].present?
            else
                @message = ''
                @question_position = @next_question_pos
            end

            Questions::SaveAnswer.new(@survey_id, @current_question.id, @answer, args[:survey_session])
            if args[:answer].present?
                if @current_question.conditions.present?
                    @condition_pos = Questions::Submission.condition_check(@current_question.id, @answer, @survey_id)
                    @question = Questions::Submission.query_question(@condition_pos, @survey_id) unless @condition_pos == false || @condition_pos == 'end'
                    Rails.logger.info ">>>>>>>>CONDITION CHECK #{@condition_pos}"
                    if @condition_pos == 'end'
                        Rails.logger.info ">>>>>>>>CONDITION TO END SURVEY"
                        @question = Questions::Submission.query_question(0, @survey_id)
                    elsif @condition_pos == false
                        Rails.logger.info ">>>>>>>>CONDITION TO NEXT"
                    end
                end
            end
            
            return @question
        end

        private

        def self.query_question(position, survey_id)
            return Question.where(survey_id: survey_id, survey_position: position).first
        end

        def self.message
            return @message
        end

        def self.result_position
            return @question_position
        end

        def self.condition_check(question_id, answer, survey_id)
            @response = ''
            @question = Question.find_by_id(question_id)
            @condition_status = false
            @condition = Condition.where(question_id: question_id).first
            if !@condition.nil?
                if @condition.method == 'is equal to'
                    if answer.include? @condition.value 
                        Rails.logger.info "WE HERE at IS EQUAL TO"
                        @next_question = Question.find_by_id(@condition.condition_question_id)
                        @condition_status = true
                    end
                end
                if @condition.method == 'is not equal to'
                    if answer.exclude? @condition.value 
                        Rails.logger.info "WE HERE at IS NOT EQUAL"
                        @next_question = Question.find_by_id(@condition.condition_question_id)
                        @condition_status = true
                    end
                end
            end
            @question = Question.where(survey_id: survey_id, survey_position: @next_question.survey_position).first unless @next_question.nil?

            if @condition.nil?
                @response = false
            elsif @condition.condition_question_id == 0
                @response = 'end'
            else
                @response = @question.survey_position
            end

            Rails.logger.info "RESPONSE #{@response}"

            return @response
        end
    end
end