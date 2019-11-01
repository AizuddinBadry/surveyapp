module Questions
    class Submission
        @message = ''
        @question = ''
        def self.submit(args = {})

            @current_question_pos = args[:q1]
            @next_question_pos = args[:q2]
            @answer = args[:answer]
            @survey_id = args[:survey_id]
            

            @next_question = Questions::Submission.query_question(@next_question_pos, @survey_id) #Query next question for return data
            @current_question = Questions::Submission.query_question(@current_question_pos, @survey_id) #Query current question to check validation, logic, etc
            
            @question = @next_question
            @mandatory = Questions::Mandatory.new(@current_question.id) unless @current_question.nil? || @next_question_pos == '1' || args[:answer].present?
            if @mandatory
                @message = 'Please fill in the answer.'
                @question =  @current_question 
            end
            
            return @question
        end

        def self.query_question(position, survey_id)
            return Question.where(survey_id: survey_id, survey_position: position).first
        end

        def self.message
            return @message
        end
    end
end