class Users::Manage::SurveysController < Users::BaseController
    before_action :get_survey, only: [:show, :update, :destroy]
    def index
        @surveys = Survey.all.order(:created_at => :desc)
    end

    def show
    end

    def new
        @survey = Survey.new
    end

    def create
        @survey = Survey.new(survey_params.to_h.merge(:user_id => current_user.id))
        if @survey.save
            respond_to do |format|
                format.html { redirect_to request.referrer, :flash => {:success => 'Successful created new survey.'}}
                format.json { render :json => @survey }
            end
        else
            flash[:danger] = @survey.errors.full_messages.first
            render :new
        end
    end

    def update
        if @survey.update survey_params
            respond_to do |format|
                format.html { redirect_to request.referrer, :flash => {:success => 'Successful updated survey.'}}
                format.json { render :json => @survey }
            end
        else
            flash[:danger] = @survey.errors.full_messages.first
            redirect_to request.referrer
        end
    end
    

    private

    def get_survey
        @survey = Survey.find(params[:id])
    end

    def survey_params
        params.require(:survey).permit(:title, :welcome_message, :show_intro_screen, :end_message, :start_button_text, 
                                        :show_final_button, :final_button_text, :final_button_url)
    end
end