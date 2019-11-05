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
          match '/preview/:id', to: 'surveys#preview', as: 'preview', via: [:get, :post]
        end
      end
      resources :survey_languages
      resources :survey_settings
      resources :question_groups do
        collection do
          post :check_logic
          put '/order/sort', to: 'question_groups#sort', as: 'group_sorting'
        end
      end
      resources :questions do
        collection do
          post :change_type
          get '/preview/:id', to: 'questions#preview', as: 'preview'
        end
      end
      resources :question_answers do
        collection do
          put :sort
        end
      end
      resources :conditions do
        collection do
        end
      end
      resources :subquestions do
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
      resources :questions, only: [:index, :show,:create] do
        collection do
          post :sort
        end
      end
      resources :surveys, only: [:show]
    end
  end

end
