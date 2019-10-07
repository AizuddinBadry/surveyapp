class Users::Manage::PersonalSettingsController < Users::BaseController
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

        if @user.update(user_params)
            respond_to do |format|
                format.html { redirect_to request.referrer, :flash => {:success => 'Successful updated Personal Information.'}}
                format.json { render :json => @user }
            end
        else
            flash[:danger] = @user.errors.full_messages.first
            redirect_to request.referrer
        end
        
    end

    def update_password
        @user = current_user
        if @user.update(password_params)
            respond_to do |format|
                format.html { redirect_to request.referrer, :flash => {:success => 'Successful updated Password Information.'}}
                format.json { render :json => @user }
            end
        else
            flash[:danger] = @user.errors.full_messages.first
            redirect_to request.referrer
        end
      end

    def destroy
    end

    private

    def get_user
        @user = current_user
    end

    def user_params
        params.require(:user).permit(:name, :email, :phone_number)
    end

    def password_params
        params.require(:user).permit(:password, :password_confirmation)
    end

end