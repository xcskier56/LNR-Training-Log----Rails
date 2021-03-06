Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        sessions:  'overrides/sessions'
      }

      resources :workout_types, :workouts
      resources :users do
        collection do
          get :current
        end
      end
    end
  end
end
