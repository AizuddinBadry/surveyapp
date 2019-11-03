module Questions
    class SaveAnswer

        def initialize(survey_id, question_id, value, session)
            @answer = SurveyAnswer.where(survey_id: survey_id, question_id: question_id, session: session).first
            if @answer.present?
                @answer.update value: value
            else
                SurveyAnswer.create survey_id: survey_id, question_id: question_id, session: session, value: value
            end
        end
    end
end