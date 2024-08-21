Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :comments do
    member do
      post 'reply'
    end
  end

  namespace :api do
    namespace :v1 do
      resources :user_followers, only: [:index, :create]
      delete '/user_followers', to: 'user_followers#destroy'
    end
  end
end
