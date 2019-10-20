class Users::Manage::SurveyLanguagesController < Users::BaseController
    before_action :set_language, only: :destroy

    def create
        @language = SurveyLanguage.new(language_params)
        if @language.save
            flash[:success] = 'Successful created new survey'
        else
            flash[:danger] = @language.errors.full_messages.first
        end
        respond_to do |format|
            format.html {redirect_to request.referrer}
        end
    end

    def destroy
        if @language.destroy
            flash[:success] = 'Successful deleted language'
        else
            flash[:danger] = @language.errors.full_messages.first
        end
        respond_to do |format|
            format.html {redirect_to request.referrer}
        end
    end
    

    private

    def set_language
        @language = SurveyLanguage.find(params[:id])
    end

    def language_params
        params.require(:survey_language).permit(:name, :survey_id)
    end
end
