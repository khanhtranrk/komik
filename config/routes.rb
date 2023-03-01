Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :auth, only: %i[] do
        collection do
          post :sign_up
          post :sign_in
          post :sign_out
          post :refresh
          post :send_verification_code
          post :reset_password
        end
      end

      namespace :app do
        resources :categories, only: %i[index]
        resources :chapters, only: %i[show]
        resources :plans, only: %i[index]
        resources :notifications, only: %i[index]
        resources :feedbacks, only: %i[create]

        resources :searchings, only: %i[index] do
          collection do
            get :suggest_keywords
          end
        end

        resources :documents, only: %[] do
          collection do
            get :policy_and_terms
            get :introduction
          end
        end

        resource :user, only: %i[show update] do
          collection do
            put :upload_avatar
            put :change_login_info
          end
        end

        resources :purchases, only: %i[index] do
          collection do
            post :card
          end
        end

        resources :comics, only: %i[index show] do
          member do
            post :like
            post :unlike
            post :follow
            post :unfollow
          end

          collection do
            get :liked
            get :followed
          end
        end
      end
    end
  end
end
