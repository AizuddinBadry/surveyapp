class Users::Manage::Settings::QuotaMembersController < Users::BaseController
    before_action :get_quota, only: [:show]

    def show
    end

    private

    def get_quota
        @quota = Quota.find(params[:id])
    end

end