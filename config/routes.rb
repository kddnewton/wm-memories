Rails.application.routes.draw do
  root to: 'stories#index'

  get 'about', to: 'home#about', as: :about
  resources :stories, only: %i[index create show] do
    get :feed, on: :collection
    post :search, on: :collection
  end
end
