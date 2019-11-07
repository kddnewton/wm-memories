# typed: strict

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'stories#index'

  get 'about', to: 'home#about', as: :about

  resources :photos, only: :show

  namespace :stories do
    resource :feed, only: :show
    resource :search, only: :create
  end

  resources :stories, only: %i[index create show]

  resources :subscriptions, only: %i[new create] do
    get :verify, on: :member
  end

  namespace :admin do
    resources :stories, only: %i[index show] do
      patch :approve, on: :member
    end
    resources :subscriptions, only: :index
  end
end
