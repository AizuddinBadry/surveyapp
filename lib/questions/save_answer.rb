module Questions
    class SaveAnswer

        def initialize(survey_id, question_id, value, session, time_per_question)
            @answer = SurveyAnswer.where(survey_id: survey_id, question_id: question_id, session: session).first
            if @answer.present?
                @answer.update value: value, time_per_question: time_per_question
            else
                SurveyAnswer.create survey_id: survey_id, question_id: question_id, session: session, value: value, time_per_question: time_per_question
            end
        end
    end
end