Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
  devise_scope :user do
    root to: "users/dashboards#index"
  end

end
