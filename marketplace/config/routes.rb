Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'produtos#index'

  resources :produtos
  devise_for :users
  resources :lojas

  get 'empresas/index'
  get 'empresas/getFossil'
  get 'empresas/getTimex'
  get 'empresas/getSchumann'
  #resources :teste
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
