module Questions
    class Mandatory
        def initialize(question_id)
            @question = Question.find_by_id(question_id)
            if @question.mandatory == true
                return true
            else
                return false
            end
        end
    end
end