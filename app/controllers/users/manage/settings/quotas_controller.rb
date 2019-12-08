class Users::Manage::Settings::QuotasController < Users::BaseController
  before_action :get_survey, only: [:show]
  before_action :get_quota, only: [:destroy]

  def show
    @quota = Quota.new
  end

  def create
    @quota = Quota.new(quota_params)
    if @quota.save
      flash[:success] = 'Successful added new quota'
      redirect_to request.referrer
    else
      flash[:danger] = @quota.errors.full_messages.first
      render :show
    end
  end

  def destroy
    if @quota.destroy
      flash[:success] = 'Successful delete quota member'
      redirect_to request.referrer
    else
      flash[:danger] = @quota.errors.full_messages.first
      redirect_to request.referrer
    end
  end

  private

  def quota_params
    params.require(:quota).permit(:name, :limit, :survey_id)
  end

  def get_quota
    @quota = Quota.find(params[:id])
  end

  def get_survey
    @survey = Survey.find_by_id(params[:id])
  end
  
end