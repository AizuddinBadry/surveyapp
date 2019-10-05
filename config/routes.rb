Rails.application.routes.draw do
  mount Shrine.presign_endpoint(:cache) => "/upload"
  
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
  devise_scope :user do
    root to: "users/dashboards#index"
  end

  namespace :users do
    namespace :manage do
      resources :surveys do
        collection do 
          get '/preview/:id', to: 'surveys#preview', as: 'preview'
        end
      end
      resources :question_groups do
        collection do
          post :check_logic
        end
      end
      resources :questions do
        collection do
          post :change_type
        end
      end
      resources :question_answers do
        collection do
          put :sort
        end
      end
      resources :company_settings do
        collection do
        end
      end
      resources :personal_settings do
        collection do
          patch :update_password
        end
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :questions, only: [:create]
    end
  end

end
