class Users::Manage::SettingsController < Users::BaseController
    before_action :get_user, only: [:index, :update]
    def index
     
    end

    def show

    end

    def new
    end

    def create
       
    end

    def update
      #  if @survey.update survey_params
      #      respond_to do |format|
      #          format.html { redirect_to request.referrer, :flash => {:success => 'Successful updated survey.'}}
      #          format.json { render :json => @survey }
      #      end
      #  else
      #      flash[:danger] = @survey.errors.full_messages.first
      #      redirect_to request.referrer
      #  end
    end

    def destroy
    end

    private

    def get_user
        @user = current_user
    end

    def user_params
       # params.require(:user).permit(:question_group_id, :q_type, :code, :description, :help, :mandatory, :position, question_answers_attributes: [:exact_value, :id])
    end

end