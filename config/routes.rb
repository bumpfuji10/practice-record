Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users do
        collection do
          get :current_user, action: :show
        end
      end

      resources :user_token, only: [:create] do
        delete :destroy, on: :collection
      end
    end
  end
end
