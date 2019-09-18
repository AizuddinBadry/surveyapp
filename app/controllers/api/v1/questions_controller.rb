class Api::V1::QuestionsController < Api::BaseController

    def create
        @question = Question.new(question_params.merge(:description => params[:questionDescription]))
        noEmptyAnswer = params[:answer].reject { |c| c.empty? }
        if noEmptyAnswer.count > 0
            noEmptyAnswer.each_with_index do |v, i|
                @question.question_answers.build(:value => i, :exact_value => v)
            end
        end
        if @question.save
            @question.update mandatory: false unless question_params[:mandatory].present?
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