Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :comments do
    member do
      post 'reply'
    end
  end
end
