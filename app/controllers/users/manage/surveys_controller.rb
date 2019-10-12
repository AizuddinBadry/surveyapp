class Users::Manage::SurveysController < Users::BaseController
    before_action :get_survey, only: [:show, :update, :destroy, :preview]
    layout 'survey', only: [:preview]
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
                format.html { redirect_to users_manage_survey_path(@survey.id), :flash => {:success => 'Successful created new survey.'}}
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

    def destroy
        if @survey.destroy
            redirect_to request.referrer, :flash => {:success => 'Successful destroyed survey.'}
        end
    end

    def preview
        if !params[:intro].present?
            set_preview_cookies
            @group = QuestionGroup.where(survey_id: @survey.id, position: cookies[:group_position]).first
            if !@group.present?
                cookies[:group_position] = cookies[:group_position].to_i + 1
                @group = QuestionGroup.where(survey_id: @survey.id, position: cookies[:group_position] + 1).first
            end
            if @group.present?
                @question = Question.where(position: cookies[:question_position], question_group_id: @group.id).first
                if !@question.present?
                    cookies[:question_position] = 1
                    @question = Question.where(position: cookies[:question_position], question_group_id: @group.id).first
                end
            else
                redirect_to preview_users_manage_surveys_path(@survey.id, final: true)
            end
        end
    end

    private

    def get_survey
        @survey = Survey.find(params[:id])
    end

    def survey_params
        params.require(:survey).permit(:title, :welcome_message, :show_intro_screen, :end_message, :start_button_text, 
                                        :show_final_button, :final_button_text, :final_button_url, :final_button_to_start)
    end

    def question_params
        params.require(:question).permit(:position, :question_group_id, :group_position)
    end

    def set_preview_cookies
        if params[:question].present?
            cookies[:group_position] = params[:question][:group_position]
            cookies[:question_position] = question_params[:position]
        else
            cookies[:group_position] = 1
            cookies[:question_position] = 1
        end
    end
end