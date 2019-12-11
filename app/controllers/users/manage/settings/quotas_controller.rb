class Users::Manage::Settings::QuotasController < Users::BaseController
  before_action :get_survey, only: [:show]
  before_action :get_quota, only: [:update, :destroy]

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
    @quota = Quota.where(survey_id: params[:id])
    if @quota.present?
      @quota.each do |q|
        @member = q.quota_members.where(question_id: params[:question_id]).first
        if @member.nil?
          render json: {status: 200}
        else
          
          if @member.question.q_type.include? 'Checkbox'

            if params[:answer].include? @member.answer_value.to_s
              if @member.quota.complete_count == @member.quota.limit
                render json: {status: 404, message: 'Thank you for your response !'}
              elsif @member.quota.complete_count < @member.quota.limit
                @member.quota.update complete_count: @member.quota.complete_count + 1
                render json: {status: 200}
              end
            else
              render json: {status: 200}
            end if @member.present?
          else
            logger.info "WOI #{params[:answer]} = #{@member.answer_value}"
            if params[:answer] == @member.answer_value || params[:answer].include?(@member.answer_value.to_s)
              if @member.quota.complete_count == @member.quota.limit
                render json: {status: 404, message: 'Thank you for your response !'}
              elsif @member.quota.complete_count < @member.quota.limit
                @member.quota.update complete_count: @member.quota.complete_count + 1
                render json: {status: 200}
              end
            else
              render json: {status: 200}
            end if @member.present?
          end
        end
      end
    else
      render json: {status: 200}
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