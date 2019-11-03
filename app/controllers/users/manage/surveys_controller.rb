class Users::Manage::SurveysController < Users::BaseController
    before_action :get_survey, only: [:show, :update, :destroy, :preview]
    layout 'survey', only: [:preview]
    def index
        @surveys = Survey.all.order(:created_at => :desc)
    end

    def show
        session.delete(:pdpa)
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
        clear_session
        if !params[:intro].present?
            set_preview_cookies  
            if !params[:back_request].present? && request.post?   
                @question = Questions::Submission.submit({survey_id: @survey.id, 
                                                            q1: request.post? ? params[:current_question_position] : nil, 
                                                            q2: cookies[:question_position], 
                                                            answer: request.post? && params[:question].present? ? params[:question][:answer] : nil,
                                                            back_request: params[:back_request]})
                cookies[:question_position] = Questions::Submission.result_position 
                @warning = Questions::Submission.message unless @question.nil?
                if !@question.present?
                    if request.xhr?
                        respond_to do |format|
                            format.js { render :json => @survey }
                        end
                    end
                    redirect_to preview_users_manage_surveys_path(@survey.id, final: true) unless params[:final].present?
                end
            else
                @question = Question.where(survey_id: @survey.id, survey_position: cookies[:question_position]).first 
            end
        end
    end

    private

    def get_survey
        @survey = Survey.find(params[:id])
    end

    def survey_params
        params.require(:survey).permit(:title, :welcome_message, :show_intro_screen, :end_message, :start_button_text, 
                                        :show_final_button, :final_button_text, :final_button_url, :final_button_to_start, :image)
    end

    def question_params
        params.require(:question).permit(:position, :question_group_id, :group_position)
    end

    def set_preview_cookies
        if params[:question].present?
            cookies[:question_position] = question_params[:position]
        else
            cookies[:question_position] ||= 1
        end
    end

    def clear_session
        if params[:clear_session].present?
            session.delete(:pdpa)
            cookies.delete(:question_position)
        elsif params[:set_session].present?
           session[:pdpa] = params[:set_session]
        else
            session[:pdpa] ||= false
            session[:survey_session] ||= SecureRandom.hex(12)
        end
    end
end