
class Question::Exists
    include Callable

    def initialize(code, group_id)
        @group_id = group_id
        @question_code = code
    end

    def call
        @current = Question.where(question_group_id: @group_id, code: @question_code).first
        if @current.present?
            return true
        else
            return false
        end
    end
end
