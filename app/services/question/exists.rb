module Question
    class Exists
        include Callable

        def initialize(code, group_id)
            @group_id = group_id
            @question_code = code
        end

        def call
            @current = Question.where(question_group_id: question_params[:question_group_id], code: question_params[:code]).first
            if @current.present?
                return true
            else
                return false
            end
        end
    end
end