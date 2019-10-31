# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: :registrations}


  root to: 'static_pages#landing_page'
  get 'static_pages/about'
  get 'static_pages/contact'
  get 'static_pages/terms_and_conditions'
  get 'static_pages/legal_information'
  get 'static_pages/privacy_policy'
  get 'full_simulations/send_email_counselour', as: :send_email_counselour

  namespace :admin do
    root to: 'users#index'
    resources :users
    resources :full_simulations, only: [:show]
    resources :gas_simulations, only: [:show]
    resources :box_simulations, only: [:show]
    resources :bank_simulations, only: [:show]
    resources :ele_simulations, only: [:show]
    resources :mobil_simulations, only: [:show]
    resources :gas_contracts
    resources :mobil_contracts
    resources :box_contracts
    resources :bank_contracts
    resources :ele_contracts

  end

  resources :users, only: %i[show edit update] do
    root to: 'full_simulations#new'
    resources :full_simulations, except: [:edit] do
      resources :gas_simulations, only: [:show, :create]
      resources :mobil_simulations, only: [:show, :create]
      resources :box_simulations, only: [:show, :create]
      resources :bank_simulations, only: [:show, :create]
      resources :ele_simulations, only: [:show, :create]
    end
  end
end
