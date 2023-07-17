Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :sessions, only: %i[] do
        collection do
          post :sign_up
          post :sign_in
          post :sign_out
          post :refresh
          post :send_verification_code
          post :reset_password
        end
      end

      namespace :admin do
        resources :comics do
          resources :reviews, only: %i[index destroy]

          member do
            put :upload_image
          end

          resources :chapters do
            member do
              put :upload_images
              put :active
            end
          end
        end

        resources :categories do
          collection do
            get :statistics
          end
        end

        resources :authors do
          member do
            put :upload_image
          end
        end

        resources :plans do
          collection do
            get :statistics_by_subscriptions
            get :statistics_by_revenue
          end
        end

        resources :purchases, except: %i[create]

        resources :documents, only: %i[show update]
        resources :feedbacks, only: %i[index]
        resources :users, only: %i[index show create update]
      end

      namespace :app do
        resources :categories, only: %i[index]
        resources :plans, only: %i[index]
        resources :notifications, only: %i[index]
        resources :feedbacks, only: %i[create]
        resources :authors, only: %i[show]

        resources :searchings, only: %i[] do
          collection do
            get :suggest_keywords
          end
        end

        resources :documents, only: %i[] do
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
            get :stripe_key
            post :card
          end
        end

        resources :comics, only: %i[index show] do
          resources :reviews, only: %i[index create update destroy] do
            collection do
              get :user_review
            end
          end

          resources :chapters, only: %i[index show]

          member do
            post :favorite
            post :unfavorite
            post :follow
            post :unfollow
          end

          collection do
            get :favorited
            get :followed
            get :up_coming
            get :read
          end
        end
      end
    end
  end
end
