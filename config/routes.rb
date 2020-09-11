Rails.application.routes.draw do
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    authenticated :user do
      root to: 'home#index', as: 'authenticated'
    end
    unauthenticated do
      root to: 'users/sessions#new', as: 'unauthenticated'
    end
  end

  namespace :admin do
    resources :users
  end
end
