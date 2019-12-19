class Api::V1::ConditionsController < Api::BaseController

    def create
        if params[:data].present?
            @created_condition = []
            @hash = SecureRandom.hex(10)
            if params[:data][:condition_types] == 'answer'
                #AnswerCondition.where(question_answer_id: params[:data][:question_answer_id]).destroy_all
                params[:data][:question_id].each_with_index do |q, i|
                    create_answer_condition(q, i)
                end
            else
                params[:data][:question_id].each_with_index do |q, i|
                    create_question_condition(q, i)
                end
            end
        end
        if @condition
            flash[:success] = 'Successful added new condition.'
            render json: @condition
        else
            flash[:danger] = @condition.errors.full_messages.first
            render json: @condition.errors.full_messages.first
        end
    end

    def destroy
        @condition = Condition.where(condition_hash: params[:id])
        if @condition.destroy_all
            respond_to do |format|
            format.html { redirect_to request.referrer , flash: {success: 'Conditions was successfully destroyed.'} }
            format.json { head :no_content }
            end
        end
      end

    private

    def create_question_condition(q,i)
        @condition = Condition.create question_id: q, condition_question_id: condition_params[:condition_question_id],
                                        value: params[:data][:value][i], method: params[:data][:method][i], scenario: condition_params[:scenario], 
                                        row: i.to_i + 1, relation: params[:data][:relation][i.to_i + 1], condition_hash: @hash
    end

    def create_answer_condition(q, i)
        AnswerCondition.where(question_answer_id: params[:data][:question_answer_id]).destroy_all
        @condition = AnswerCondition.create question_id: q, condition_question_id: condition_params[:condition_question_id],
                        value: params[:data][:value][i], method: params[:data][:method][i], scenario: condition_params[:scenario], 
                        row: i.to_i + 1, relation: params[:data][:relation][i.to_i + 1], question_answer_id: params[:data][:question_answer_id]
    end

    def condition_params
        params.require(:data).permit(:question_id, :condition_question_id, :value, :scenario, :method)
    end
end