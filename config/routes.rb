Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    get 'student-signup' => 'users/registrations#new', role: 'intern'
    get 'startup-signup' => 'users/registrations#new', role: 'startup'
  end

  root to: 'static_pages#show', page: 'home'

  get 'overview'    => 'static_pages#show', page: 'overview'
  get 'information' => 'static_pages#show', page: 'information'
  get 'the-details' => 'static_pages#show', page: 'the-details'
  get 'about-us'    => 'static_pages#show', page: 'about-us'

  resources :matches, only: [:create]

  resources :intern_profiles, only: [:show, :edit, :update], path: :interns
  resources :startup_profiles, only: [:show, :edit, :update], path: :startups

  resources :listings

  get 'admin' => 'admin#index'
  get 'admin/download' => 'admin#download', as: 'admin_download'
  namespace :admin do
    resources :categories
    resources :locations
    resources :matches, only: [:index]
    resources :featured_startups, only: [:new, :create, :destroy]
    resources :settings
  end

  get 'search' => 'searches#index'

  Rails.application.routes.draw do
    get '/pages/:page' => 'static_pages#show'
  end
end
