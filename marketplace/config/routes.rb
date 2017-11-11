Rails.application.routes.draw do
  resources :produtos
  devise_for :users
  resources :lojas

  root 'produtos#index'

  get 'empresas/index'
  get 'empresas/getFossil'
  get 'empresas/getTimex'
  get 'empresas/getSchumann'
  #resources :teste
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
