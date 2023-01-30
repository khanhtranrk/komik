Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :auth, only: %i[] do
        collection do
          post :sign_up
          post :sign_in
          post :sign_out
          post :refresh
        end
      end

      namespace :app do
        resources :categories, only: %i[index]
        resources :chapters, only: %i[show]

        resource :user, only: %i[show update] do
          collection do
            put :change_login_info
          end
        end

        resources :comics, only: %i[index show] do
          member do
            post :like
            post :unlike
            post :follow
            post :unfollow
          end
        end
      end
    end
  end
end
