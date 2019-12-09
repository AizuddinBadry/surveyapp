class Users::Manage::Settings::QuotaMembersController < Users::BaseController
    before_action :get_quota, only: [:show]

    def show
        @quota_member = QuotaMember.new
        @items = Question.where(survey_id: @quota.survey_id).order(survey_position: :asc)
    end

    def create
        @quota_member = QuotaMember.new(member_params)
        if @quota_member.save
            flash[:success] = 'Successful added quota member'
        else
            flash[:danger] = @quota_member.errors.full_messages.first
        end
        redirect_to request.referrer
    end

    def destroy
        @quota_member = QuotaMember.find(params[:id])
        if @quota_member.destroy
            flash[:success] = 'Successful deleted quota member'
        else
            flash[:danger] = @quota_member.errors.full_messages.messages
        end
        redirect_to request.referrer
    end
    

    private

    def member_params
        params.require(:quota_member).permit(:question_id, :answer_value, :quota_id)
    end

    def get_quota
        @quota = Quota.find(params[:id])
    end

end