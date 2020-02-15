class Users::Manage::SubmissionsController < Users::BaseController
   before_action :get_submission, only: [:show]
    def index
        
    end

    def show
        @submission = SurveyAnswer.joins(:survey,:question).where(survey_id: @survey.id).order(created_at: :desc)

        respond_to do |format|
            format.html
            format.csv { send_data @submission.to_csv, filename: "Survey-Submission-#{@survey.title}.csv" }
          end
    end

    def detail_submissions
        @breadcrumb = SurveyAnswer.joins(:survey,:question).where(session: params[:id]).first
        @submissions = SurveyAnswer.joins(:survey,:question).where(session: params[:id]).order(created_at: :asc)

        respond_to do |format|
            format.html
            format.csv { send_data @submissions.to_csv, filename: "Survey-Submission-#{@breadcrumb.session}.csv" }
          end
    end

    def new
       
    end

    def create
      
    end

    def update
       
    end

    def destroy
    end

    private

    def get_submission

            @survey = Survey.find(params[:id])
       
    end

    def submission_params
        params.require(:submission).permit()
    end

end