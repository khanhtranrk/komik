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
    end
  end
end
