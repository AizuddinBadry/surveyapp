class Users::Manage::SurveysController < Users::BaseController
    def index
    end

    def new
        @survey = Survey.new
    end

    def create
    end
end