class Users::Manage::Settings::QuotasController < Users::BaseController
  before_action :get_survey, only: [:show]
  before_action :get_quota, only: [:update, :destroy, :release]

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

  def update
    if @quota.update(quota_params)
      flash[:success] = 'Successful update quota'
      redirect_to request.referrer
    else
      flash[:danger] = @quota.errors.full_messages.first
      redirect_to request.referrer
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

  def check_quota
    @member = QuotaMember.joins(:quota).where(quota: {survey_id: params[:id]}, question_id: params[:question_id])
    if @member.quota.release?
      render json: {status: 200}
    else
      if @member.present?
        @answer = JSON.parse params[:answer]
        @member.each do |m|
          if m.question.q_type.include?('Checkbox')
            if @answer.include? m.answer_value.to_s
              quota_limit_condition(m)
            end
          else
            if @answer == m.answer_value || @answer.include?(m.answer_value.to_s)
              quota_limit_condition(m)
            end
          end
        end
      else
        render json: {status: 200}
      end
    end
  end

  private

  def quota_params
    params.require(:quota).permit(:name, :limit, :survey_id, :message, :url_redirection)
  end

  def get_quota
    @quota = Quota.find(params[:id])
  end

  def quota_limit_condition(m)
    if m.quota.complete_count == m.quota.limit
      render json: {status: 404, message: m.quota.message, url: m.quota.url_redirection}
    elsif m.quota.complete_count < m.quota.limit
      m.quota.update complete_count: m.quota.complete_count + 1
      render json: {status: 200}
    end
  end

  def get_survey
    @survey = Survey.find_by_id(params[:id])
  end
  
end