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
          post '/clone/:id', to: 'surveys#clone', as: 'clone'
          match '/preview/:id', to: 'surveys#preview', as: 'preview', via: [:get, :post]
          get '/expire/:id', to: 'surveys#expire', as: 'expire'
        end
      end
      resources :submissions do
        collection do
          get '/detail/:id', to: 'submissions#detail_submissions', as: 'detail_submissions'
        end
      end
      resources :survey_languages
      resources :survey_settings
      resources :question_groups do
        collection do
          post :check_logic
          put '/order/sort', to: 'question_groups#sort', as: 'group_sorting'
        end
        member do
          get '/preview/:question_id', action: :preview, as: 'preview'
        end
      end
      resources :questions do
        collection do
          post :change_type
          post :import_question
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
      
      namespace :settings do
        resources :quotas, only: [:show, :create, :update, :destroy] do 
          member do
            get :check_quota
          end
        end
        resources :quota_members, only: [:show, :create, :destroy] do
          member do
            post :release
          end
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
      resources :surveys, only: [:index,:show]
      resources :conditions, only: [:create,:destroy]
    end
  end

end
