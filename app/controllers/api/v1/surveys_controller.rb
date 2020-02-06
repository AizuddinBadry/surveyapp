class Api::V1::SurveysController < Api::BaseController

    def index
        @surveys = Survey.where(user_id: current_user.id)
        render json: @surveys
    end

    def show
        @survey = Survey.find_by_id(params[:id])
        render json: @survey.to_json( :include => { 
                                        :question_groups => { 
                                            :include => {
                                                :questions => { :include => [
                                                    :question_answers]
                                                }}}})
    end
end