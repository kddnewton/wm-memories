Rails.application.routes.draw do
  root to: 'stories#index'

  get 'about', to: 'home#about', as: :about

  resources :stories, only: %i[index create show] do
    get :feed, on: :collection
    post :search, on: :collection
  end

  resources :subscriptions, only: %i[new create] do
    get :verify, on: :member
  end

  namespace :admin do
    resources :stories, only: :index do
      patch :approve, on: :member
    end
    resources :subscriptions, only: :index
  end

  namespace :api do
    namespace :v1 do
      resources :stories, only: %i[index show create]
    end
  end
end
