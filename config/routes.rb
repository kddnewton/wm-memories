Rails.application.routes.draw do
  root to: 'stories#index'

  get 'about', to: 'home#about', as: :about

  resources :stories, only: %i[index create show] do
    collection do
      get :feed
      post :search
    end
  end

  resources :subscriptions, only: %i[new create]

  namespace :admin do
    resources :stories, only: :index
    resources :subscriptions, only: :index
  end
end
