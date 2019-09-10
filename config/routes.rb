Rails.application.routes.draw do

  root :to => "static_pages#landing_page"
  get 'static_pages/about'
  get 'static_pages/contact'

  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
