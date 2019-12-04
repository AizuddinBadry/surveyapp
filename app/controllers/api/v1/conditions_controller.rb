class Api::V1::ConditionsController < Api::BaseController

    def create
        if params[:data].present?
            @created_condition = []
            params[:data][:question_id].each_with_index do |q, i|
                @condition = Condition.create question_id: q, condition_question_id: condition_params[:condition_question_id],
                                    value: params[:data][:value][i], method: params[:data][:method][i], scenario: condition_params[:scenario], 
                                    row: i.to_i + 1, relation: params[:data][:relation][i.to_i + 1]
                #@created_condition << @condition.id
                
                #if params[:data][:relation][i].present?
                    #@last_condition = i - 1
                    #ConditionLink.create! question_id: q, condition_id: @condition.id, relation: params[:data][:relation][i], 
                     #                   other_condition_id: @created_condition[@last_condition]
                #end
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
        @condition = Condition.where(question_id: params[:id])
        if @condition.destroy_all
            respond_to do |format|
            format.html { redirect_to request.referrer , flash: {success: 'Conditions was successfully destroyed.'} }
            format.json { head :no_content }
            end
        end
      end

    private

    def condition_params
        params.require(:data).permit(:question_id, :condition_question_id, :value, :scenario, :method)
    end
end