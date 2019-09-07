Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
  devise_scope :user do
    root to: "users/dashboards#index"
  end

  namespace :users do
    namespace :manage do
      resources :surveys
    end
  end

end
