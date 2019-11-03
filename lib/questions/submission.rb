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
    end
end