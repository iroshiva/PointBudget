# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: :registrations }

  root to: 'static_pages#landing_page'
  get 'static_pages/about'
  get 'static_pages/contact'

  namespace :admin do
    root to: 'users#index'
    resources :users
    resources :gas_contracts
    resources :ele_contracts
  end

  resources :users, only: %i[show edit update] do
    root to: 'users#show'
    resources :full_simulations do
      resources :energies, only: %i[show new]
      resources :gas_simulations, except: [:index]
      resources :ele_simulations, except: [:index]
    end
  end
end
