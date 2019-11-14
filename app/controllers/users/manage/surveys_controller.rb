class Users::Manage::SurveysController < Users::BaseController
    before_action :get_survey, only: [:show, :update, :destroy, :preview, :expire]
    layout 'survey', only: [:preview]
    def index
        @surveys = Survey.all.order(:created_at => :desc)
    end

    def expire
        render layout: "expired"
        
    end

    def show
        session.delete(:pdpa)
        cookies[:survey_session] = SecureRandom.hex(12)
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
                                                            q2: cookies[:question_position], time_per_question: params[:question][:time_per_question],
                                                            answer: request.post? && params[:question].present? ? params[:question][:answer] : nil,
                                                            back_request: params[:back_request],
                                                            survey_session: cookies[:survey_session]})
                cookies[:question_position] = Questions::Submission.result_position 
                generate_interpolation(@survey.id)
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
        params.require(:survey).permit(:title,:status, :welcome_message, :show_intro_screen, :end_message, :start_button_text, 
                                        :show_final_button, :final_button_text, :final_button_url, :final_button_to_start, :image)
    end

    def question_params
        params.require(:question).permit(:position, :question_group_id, :group_position, :time_per_question, :answer)
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
        end
    end

    def clear_survey_session
        cookies.delete(:survey_session)
    end

    def generate_interpolation(survey_id)
        @interpolation = Hash.new
        Question.joins(:survey_answers).where("survey_answers.session ilike ?", cookies[:survey_session]).where(survey_id: survey_id).each do |i|
            string = "#{i.code}"+"_"+"value"
            survey_answer = SurveyAnswer.where(question_id: i.id, session: cookies[:survey_session]).first
            exact_value = ''
            array = JSON.parse(survey_answer.value) unless survey_answer.value == nil || !survey_answer.value.is_a?(Integer)
            if array.kind_of?(Array)
                array.each_with_index do |v, index|
                    answer = QuestionAnswer.where(question_id: i.id, value: v.to_i).first
                    if index == 0
                        exact_value += "#{answer.exact_value}"
                    else
                        exact_value += ",#{answer.exact_value}"
                    end
                end
            else
                answer = QuestionAnswer.where(question_id: i.id, value: survey_answer.value).first
                exact_value += answer.exact_value unless answer.nil?
            end unless survey_answer.nil?
            @interpolation[string.to_sym] = exact_value
        end
    end
end