class Users::Manage::Settings::QuotasController < Users::BaseController
  before_action :get_survey, only: [:show]

  def show
  end

  private

  def get_survey
  end
  
end