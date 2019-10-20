class Users::Manage::SurveySettingsController < Users::BaseController
  before_action :set_survey, only: [:show, :update]

  # GET /survey_settings
  # GET /survey_settings.json
  def index
    @survey_settings = SurveySetting.all
  end

  # GET /survey_settings/1
  # GET /survey_settings/1.json
  def show
    @survey_setting = SurveySetting.new unless @survey.survey_setting.present?
    @survey_setting ||= @survey.survey_setting
    @language = SurveyLanguage.new
    @languages = SurveyLanguage.where(survey_id: @survey.id)
  end

  # GET /survey_settings/new
  def new
    @survey_setting = SurveySetting.new
  end

  # GET /survey_settings/1/edit
  def edit
  end

  # POST /survey_settings
  # POST /survey_settings.json
  def create
    @survey_setting = SurveySetting.new(survey_setting_params)

    respond_to do |format|
      if @survey_setting.save
        format.html { redirect_to @survey_setting, notice: 'Survey setting was successfully created.' }
        format.json { render :show, status: :created, location: @survey_setting }
      else
        format.html { render :new }
        format.json { render json: @survey_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /survey_settings/1
  # PATCH/PUT /survey_settings/1.json
  def update
    respond_to do |format|
      @survey.build_survey_setting survey_id: params[:survey_setting][:id] unless SurveySetting.find_by_survey_id(params[:survey_setting][:id]).present?
      if @survey.survey_setting.update(survey_setting_params)
        format.html { redirect_to request.referrer, flash: {success: 'Survey setting was successfully updated.'} }
        format.json { render :show, status: :ok, location: @survey_setting }
      else
        format.html { render :edit }
        format.json { render json: @survey_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /survey_settings/1
  # DELETE /survey_settings/1.json
  def destroy
    @survey_setting.destroy
    respond_to do |format|
      format.html { redirect_to survey_settings_url, notice: 'Survey setting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_setting_params
      params.require(:survey_setting).permit(:enable_pdpa, :pdpa_message, :pdpa_error_message)
    end
end
