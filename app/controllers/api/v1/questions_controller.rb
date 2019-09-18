class Api::V1::QuestionsController < Api::BaseController

    def create
        @question = Question.new(question_params.merge(:description => params[:questionDescription]))
        if @question.save
            params[:question][:answer].each_with_index |v, i| do
                @question.build_question_answer :value => i, :exact_value => v
            end unless !params[:question][:answer].present?
            flash[:success] = 'Successful created new question.'
            render json: {object: @question, status: 200}
        else
            render json: {object: @question.errors.full_messages.first, status: 404}
        end
    end

    private

    def question_params
        params.require(:question).permit(:question_group_id, :q_type, :code, :description, :help, :mandatory, :position)
    end
end