class Users::Manage::CompanySettingsController < Users::BaseController
   before_action :get_company, only: [:create, :index, :update]
    def index
            
    end

    def show

    end

    def new
       
    end

    def create
       @company = Company.new(company_params)
    respond_to do |format|
      if @company.save
        current_user.update_attributes(company_id: @company.id)
        format.html { redirect_to request.referrer, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
    end

    def update
        if @company.update_attributes(company_params)
            respond_to do |format|
                format.html { redirect_to request.referrer, :flash => {:success => 'Successful updated company.'}}
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

         if current_user.company_id.present?
            @company = Company.find(current_user.company_id)
        else
             @company = Company.new()   
        end
       
    end

    def company_params
        params.require(:company).permit(:name, :image)
    end

end