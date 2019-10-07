class Users::Manage::CompanySettingsController < Users::BaseController
    before_action :get_company, only: [:index, :update]
    def index
     
    end

    def show

    end

    def new
    end

    def create
       
    end

    def update

        if @company.update_attributes(company_params)
            respond_to do |format|
                format.html { redirect_to request.referrer, :flash => {:success => 'Successful updated survey.'}}
                format.json { render :json => @company }
            end
        else
            flash[:danger] = @company.errors.full_messages.first
            redirect_to request.referrer
        end
    end

    def destroy
    end

    private

    def get_company
        @company = Company.find(current_user.id)
    end

    def company_params
        params.require(:company).permit(:name, :image)
    end

end