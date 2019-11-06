class Api::V1::ConditionsController < Api::BaseController

    def create
        @condition = Condition.new condition_params
        if @condition.save
            flash[:success] = 'Successful added new condition.'
            render json: @condition
        else
            flash[:danger] = @condition.errors.full_messages.first
            render json: @condition.errors.full_messages.first
        end
    end

    def destroy
        @condition = Condition.find(params[:id])
        @condition.destroy
        respond_to do |format|
          format.html { redirect_to request.referrer , flash: {success: 'Conditions was successfully destroyed.'} }
          format.json { head :no_content }
        end
      end

    private

    def condition_params
        params.permit(:question_id, :condition_question_id, :value, :scenario, :method)
    end
end