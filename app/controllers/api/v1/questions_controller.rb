class Api::V1::QuestionsController < Api::BaseController

    def create
        @question = Question.new(question_params.merge(:description => params[:questionDescription]))
        noEmptyAnswer = params[:answer].reject { |c| c.empty? } unless !params[:answer].present?
        if params[:answer].present?
            if noEmptyAnswer.count > 0
                noEmptyAnswer.each_with_index do |v, i|
                    @question.question_answers.build(:value => i, :exact_value => v, :code => params[:code][i])
                end
            end
        end
        if Question::Exists.new(question_params[:code], question_params[:question_group_id])
            render json: {object: 'Code is exists!', status: 500}, status: 500
        else
            if @question.save
                @question.update mandatory: false unless question_params[:mandatory].present?
                flash[:success] = 'Successful created new question.'
                render json: {object: @question, status: 200}
            else
                render json: {object: @question.errors.full_messages.first, status: 404}
            end
        end
    end

    def sort
    end

    private

    def question_params
        params.require(:question).permit(:question_group_id, :q_type, :code, :description, :help, :mandatory, :limit ,:position)
    end

    
end