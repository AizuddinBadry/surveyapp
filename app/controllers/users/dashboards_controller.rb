class Users::DashboardsController < Users::BaseController
    def index
        @users = current_user
    end
end