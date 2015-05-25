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
end
