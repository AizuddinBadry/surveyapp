class Api::V1::QuestionsController < Api::BaseController

    def index
        @questions = Question.where(survey_id: params[:survey_id]).order(survey_position: :asc)
        render json: {object: @questions}
    end

    def show
        @question = Question.find_by_id(params[:id])
        render json: @question.to_json( :include => :question_answers )
    end

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
        if Question::Exists.new(question_params[:code], question_params[:question_group_id]).call
            render json: {object: 'Code is exists!', status: 500}, status: 500
        else
            if @question.save
                Question.reorder_survey_position(@question.survey_id)
                @question.update mandatory: false unless question_params[:mandatory].present?
                flash[:success] = 'Successful created new question.'
                render json: {object: @question, status: 200}
            else
                render json: {object: @question.errors.full_messages.first, status: 404}
            end
        end
    end

    def sort
        @question = Question.where(question_group_id: params[:question_group_id], code: params[:code]).first
        if @question.update position: params[:position]
            Question.reorder_survey_position(@question.survey_id)
            render json: @question, status: 200
        else
            render json: 'Cannot reorder position', status: 404
        end
    end

    private

    def question_params
        params.require(:question).permit(:question_group_id, :q_type, :code, :description, 
                                            :help,:question_desc,:desc_question_code, :mandatory, :limit ,:position, :survey_id)
    end

    
end