module Surveys
    class Submission
        def submit(args = {})
            @current_question_id = args[:current_question_id]
            @next_question_id = args[:next_question_id]
        end
    end
end