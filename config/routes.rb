Rails.application.routes.draw do
  get 'errors/not_found', to: 'errors#not_found'

  get 'errors/internal_server_error', to: 'errors#internal_server_error'


  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'home#index'

  resources :users, except: [:destroy]

  post '/cart',          to: 'cart#create'
  put '/cart_update',   to: 'cart#update'

  resources :cart, only: [:index]

  resources :loans, only: [:index]
  get '/order_summary', to: 'loans#order_summary', as: :order_summary

  resources :loan_requests, only: [:index, :new, :show, :create, :update, :edit]

  delete "loan_requests/:id/cart", to: 'cart#remove_loan_request', as: :cart_item

  resources :categories, as: :category, path: 'categories', param: :slug, only: [:show, :edit, :index]

  get '/login',  to: 'sessions#new'
  post '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'tenants', to: 'tenants#index'
  post 'tenants', to: 'tenants#create'

  resources :tenants, as: :tenant, path: '', param: :slug, except: [:destroy]
  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server_error'

  get '*path', to: 'errors#not_found'
end
